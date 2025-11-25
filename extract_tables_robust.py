#!/usr/bin/env python3
"""
extract_tables_robust.py

Extract tables from a PDF into a JSON structure with robust header detection.
- Uses pdfplumber + pandas
- Infers column roles (Name, Job Title, Department, Contact, Email, Office Location)
  by sampling several rows and checking for email/phone/location/title patterns.
- Reuses last-detected header across pages/tables when explicit header row is missing.
"""

import json
import argparse
import re
from typing import List, Any, Tuple, Optional
import pdfplumber
import pandas as pd
import os

EMAIL_RE = re.compile(r"[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+")
PHONE_RE = re.compile(r"(\+?\d[\d\-\s\(\)]{4,}\d)")
# simple title keywords to detect job-title-like cells
TITLE_KEYWORDS = ["manager", "analyst", "senior", "jr", "sr", "director", "officer", "trader", "engineer",
                  "lead", "head", "consultant", "associate", "specialist", "supervisor", "executive"]
DEPT_KEYWORDS = ["banking", "trading", "finance", "operations", "risk", "compliance",
                 "digital", "technology", "it", "sales", "marketing", "hr", "human resources"]
KNOWN_HEADER_PREFERENCES = ["Name", "Job Title", "Department", "Contact", "Email", "Office Location"]

def normalize_cell(x: Any) -> str:
    if x is None:
        return ""
    return str(x).strip()

def column_features(sample_cells: List[str]) -> dict:
    """Compute heuristic scores for a column based on sample cells (strings)."""
    n = len(sample_cells)
    email_count = sum(1 for c in sample_cells if EMAIL_RE.search(c))
    phone_count = sum(1 for c in sample_cells if PHONE_RE.search(c))
    location_count = sum(1 for c in sample_cells if "," in c and len(c.split()) >= 2)
    title_count = sum(1 for c in sample_cells if any(tok in c.lower() for tok in TITLE_KEYWORDS))
    dept_count = sum(1 for c in sample_cells if any(tok in c.lower() for tok in DEPT_KEYWORDS))
    numeric_count = sum(1 for c in sample_cells if any(ch.isdigit() for ch in c))
    avg_len = sum(len(c) for c in sample_cells) / max(1, n)
    # return fractions and meta
    return {
        "email_frac": email_count / max(1, n),
        "phone_frac": phone_count / max(1, n),
        "location_frac": location_count / max(1, n),
        "title_frac": title_count / max(1, n),
        "dept_frac": dept_count / max(1, n),
        "numeric_frac": numeric_count / max(1, n),
        "avg_len": avg_len
    }

def infer_header_from_samples(rows: List[List[str]], prev_header: Optional[List[str]] = None) -> List[str]:
    """Infer a header (column names) for a table rows list using column features."""
    if not rows:
        return prev_header or []

    # limit to first few rows (including the first row which might be header or data)
    sample_len = min(6, len(rows))
    samples = [ [normalize_cell(cell) for cell in row] for row in rows[:sample_len] ]
    ncols = max(len(r) for r in samples)

    # pad rows to ncols with empty string
    for r in samples:
        if len(r) < ncols:
            r.extend([""] * (ncols - len(r)))

    # compute features per column
    col_samples = []
    for ci in range(ncols):
        col_cells = [samples[ridx][ci] for ridx in range(sample_len)]
        col_samples.append(col_cells)

    features = [column_features(c) for c in col_samples]

    # try to map columns to known target roles by highest score
    mapping = [None] * ncols
    assigned = set()

    # priority mapping order for reliable detection
    for role in ["Email", "Contact", "Office Location", "Job Title", "Department"]:
        best_ci = None
        best_score = 0.0
        for ci, feat in enumerate(features):
            if ci in assigned:
                continue
            score = 0.0
            if role == "Email":
                score = feat["email_frac"]
            elif role == "Contact":
                score = feat["phone_frac"]
            elif role == "Office Location":
                score = feat["location_frac"]
            elif role == "Job Title":
                score = feat["title_frac"]
            elif role == "Department":
                score = feat["dept_frac"]
            # small boost if avg_len reasonable for role
            if feat["avg_len"] > 3:
                score += 0.01
            if score > best_score:
                best_score = score
                best_ci = ci
        # assign if confident
        if best_ci is not None and best_score >= 0.4:
            mapping[best_ci] = role
            assigned.add(best_ci)

    # remaining columns -> likely Name or fallback col_i
    for ci in range(ncols):
        if mapping[ci] is None:
            # prefer Name if not assigned anywhere
            mapping[ci] = "Name"

    # If prev_header exists and has same ncols, prefer prev_header (most stable)
    if prev_header and len(prev_header) == ncols:
        # But only if prev_header contains any of expected keywords to avoid propagating bad header
        prev_lowers = [h.lower() for h in prev_header]
        if any(k in "".join(prev_lowers) for k in ("name","email","contact","department","office","location","job","title")):
            return prev_header

    # produce final header in desired column order:
    # If we have some set of roles and count equals 6 or close, order them as KNOWN_HEADER_PREFERENCES where possible else use mapping names
    final = []
    # produce list that aligns Name/Job Title/Department/Contact/Email/Office Location
    # but if multiple Name columns exist, keep them as 'Name', 'Name_2', etc.
    role_counts = {}
    for m in mapping:
        role_counts[m] = role_counts.get(m, 0) + 1

    built = []
    # Try to place known roles in canonical order if present in mapping
    for desired in KNOWN_HEADER_PREFERENCES:
        found_index = None
        for ci, m in enumerate(mapping):
            if m == desired:
                found_index = ci
                break
        if found_index is not None:
            built.append(desired)
            mapping[found_index] = None  # consume
    # any remaining mapping entries -> create unique labels
    for m in mapping:
        if m is None:
            continue
        # if label already used add suffix
        label = m
        cnt = sum(1 for b in built if b == label)
        if cnt:
            label = f"{label}_{cnt+1}"
        built.append(label)

    return built

def rows_to_records(rows: List[List[Any]], prev_header: Optional[List[str]] = None) -> Tuple[List[dict], Optional[List[str]]]:
    """Convert raw table rows (list of lists) into list of dict records and detected header."""
    if not rows:
        return [], prev_header

    # normalize rows to strings
    norm_rows = []
    for r in rows:
        norm_rows.append([normalize_cell(c) for c in r])

    # drop fully empty rows
    filtered = [r for r in norm_rows if not all((c == "" for c in r))]
    if not filtered:
        return [], prev_header

    # If the first row seems to be a header (contains header-keywords), treat it as header
    first = filtered[0]
    first_lower = [c.lower() for c in first]
    header_keywords = {"name", "job", "title", "department", "contact", "email", "office", "location"}
    contains_header_kw = any(any(kw in cell for kw in header_keywords) for cell in first_lower)

    # decision: if first row contains header keywords, treat as header
    if contains_header_kw:
        header = [normalize_cell(c) for c in first]
        data_rows = filtered[1:]
        # pad data rows
        ncols = len(header)
        for r in data_rows:
            if len(r) < ncols:
                r.extend([""] * (ncols - len(r)))
    else:
        # infer header using column feature analysis and prev_header as hint
        header = infer_header_from_samples(filtered, prev_header=prev_header)
        data_rows = filtered

    # convert to dicts using header (pad rows)
    ncols = len(header)
    records = []
    for r in data_rows:
        row = list(r) + [""] * max(0, ncols - len(r))
        rec = {}
        for ci in range(ncols):
            key = header[ci] if ci < len(header) else f"col_{ci+1}"
            rec[key] = normalize_cell(row[ci])
        records.append(rec)

    return records, header

def extract_tables(pdf_path: str, pages: str = "all"):
    out = {"source": os.path.basename(pdf_path), "tables": []}
    last_header = None
    with pdfplumber.open(pdf_path) as pdf:
        # prepare page indexes
        if pages.strip().lower() == "all":
            page_idxs = list(range(len(pdf.pages)))
        else:
            page_idxs = []
            parts = [p.strip() for p in pages.split(",") if p.strip()]
            for part in parts:
                if "-" in part:
                    a, b = part.split("-", 1)
                    page_idxs.extend(range(int(a)-1, int(b)))
                else:
                    page_idxs.append(int(part)-1)
            page_idxs = [p for p in page_idxs if 0 <= p < len(pdf.pages)]

        for pi in page_idxs:
            page = pdf.pages[pi]
            tables = page.find_tables()
            if not tables:
                ext_tables = page.extract_tables()
                for ti, rows in enumerate(ext_tables):
                    records, header = rows_to_records(rows, prev_header=last_header)
                    if records:
                        out["tables"].append({
                            "page": pi + 1,
                            "table_index": ti,
                            "header": header,
                            "rows": records
                        })
                        if header:
                            last_header = header
                continue

            for ti, t in enumerate(tables):
                rows = t.extract()
                records, header = rows_to_records(rows, prev_header=last_header)
                if records:
                    out["tables"].append({
                        "page": pi + 1,
                        "table_index": ti,
                        "bbox": t.bbox,
                        "header": header,
                        "rows": records
                    })
                    if header:
                        last_header = header
    return out

def main():
    parser = argparse.ArgumentParser(description="Extract tables from PDF into robust JSON")
    parser.add_argument("pdf", help="Path to PDF file (e.g. HeiFinance_Full_Directory_Complete.pdf)")
    parser.add_argument("-p", "--pages", default="all", help="Pages to process (e.g. '1,3,5-7' or 'all')")
    parser.add_argument("-o", "--out", default="tables.json", help="Output JSON file")
    args = parser.parse_args()

    result = extract_tables(args.pdf, pages=args.pages)
    with open(args.out, "w", encoding="utf-8") as f:
        json.dump(result, f, ensure_ascii=False, indent=2)
    print(f"Saved {len(result['tables'])} tables to {args.out}")

if __name__ == "__main__":
    main()


# python extract_tables_robust.py "path/to/HeiFinance_Full_Directory_Complete.pdf" -o hei_tables.json

# or for specific pages:
# python extract_tables_robust.py "path/to/HeiFinance_Full_Directory_Complete.pdf" -p "1-3" -o hei_tables.json