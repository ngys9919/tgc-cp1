# (base)
# ERIC NG@LAPTOP-MT5ND6S9 MINGW64 e/source/tgc-cp1
# $ C:\\ProgramData\\miniconda3\\python.exe src/app.py

python src/app.py

# (base)
# ERIC NG@LAPTOP-MT5ND6S9 MINGW64 e/source/tgc-cp1
# $ bash run-gradio.sh

# E:\source\tgc-cp1\src\app.py:310:
# demo.launch(share=False, debug=True)

# E:\source\tgc-cp1\src\app.py:310: 
# UserWarning: You have not specified a value for the `type` parameter. 
# Defaulting to the 'tuples' format for chatbot messages, 
# but this is deprecated and will be removed in a future version of Gradio. 
# Please set type='messages' instead, which uses openai-style dictionaries with 'role' and 'content' keys.
#   chatbot = gr.Chatbot(label="Chat")
# * Running on local URL:  http://127.0.0.1:7860
# * To create a public link, set `share=True` in `launch()`.

# http://127.0.0.1:7860

# You can now open the link in your browser.

# E:\source\tgc-cp1\src\app.py:311:
# demo.launch(share=True)

### Case1: Missing file

# * Running on local URL:  http://127.0.0.1:7860
# Could not create share link. Missing file: C:\Users\ERIC NG\.cache\huggingface\gradio\frpc\frpc_windows_amd64_v0.3.

# Please check your internet connection. This can happen if your antivirus software blocks the download of this file. You can install manually by following these steps:

# 1. Download this file: https://cdn-media.huggingface.co/frpc-gradio-0.3/frpc_windows_amd64.exe       
# 2. Rename the downloaded file to: frpc_windows_amd64_v0.3
# 3. Move the file to this location: C:\Users\ERIC NG\.cache\huggingface\gradio\frpc

### Case2: Internet connection issue (Because of Norton Antivirus blocking using Qurantine, do an exception to allow using Exclusions in Norton)

# * Running on local URL:  http://127.0.0.1:7860
# Could not create share link. Please check your internet connection or our status page: https://status.gradio.app.

### Case3: Successful share link creation

# * Running on local URL:  http://127.0.0.1:7860
# * Running on public URL: https://de7a8d7911928109a3.gradio.live

# This share link expires in 1 week. For free permanent hosting and GPU upgrades, run `gradio deploy` from the terminal in the working directory to deploy to Hugging Face Spaces (https://huggingface.co/spaces)

# You can now open the link in your browser.

### Using src/app.py:

# Upload a PDF file first, e.g., sample.pdf

# Then try these prompts:

# Prompt Examples:
# Text Output Only

# Can you summarize the content of the uploaded PDF?

# What are the key points discussed in the document?

# Can you explain the main arguments presented in the PDF?

# Upload a PDF file first, say HeiFinance_Employee_Handbook.pdf
# Prompt Examples:

# Query 1: Can you summarize the content of the uploaded PDF?

# The provided PDF is the HeiFinance Employee Handbook. It outlines terms and conditions of employment, policies, procedures, and standards of conduct. It clarifies that the handbook is a guide and not an employment contract, with the Letter of Appointment or Singapore Employment Act prevailing in case of conflicts. The handbook also covers probationary periods, termination of service and resignation, involuntary termination/dismissal, appointment procedures including pre-employment checks and work pass requirements, and company rights regarding job assignments. It also touches upon policies concerning non-competition and the usage of internet and electronic mail. The management reserves the right to revise these policies.

# Query 2: What are the key points discussed in the document?

# The document discusses the introduction to the HeiFinance Employee Handbook, including its purpose and disclaimers. It also covers terms of employment such as probationary periods and termination of service, including notice periods and resignation procedures. Additionally, it addresses policies on non-competition, internet and electronic mail usage, and non-disclosure of information. The handbook also mentions a whistle-blowing program.

# Query 3: Can you explain the main arguments presented in the PDF?

# I don't know.

# Query 4: What is the working hours?

# The standard working week for all non-shift employees is 40 hours over 5 working days, Monday to Friday. General office hours are 9:00 AM to 6:00 PM with a 1-hour lunch break. The lunch break is from 1:00 PM to 2:00 PM. Specific departments, particularly those in front-office, trading, or operations roles, may have different working hours or shift arrangements, which will be specified in the Letter of Appointment or departmental guidelines.

# Query 5: What is the procedure for handling complaints?

# I don't know.

# Query 6: What is the company's policy on outside employment?

# Employees are expected to dedicate their full working time and attention to the company. They are not allowed to take on outside employment, business, or professional activities that could create a conflict of interest or hinder their ability to perform their duties effectively. Any outside employment must be declared to and approved in writing by the Head of Human Resources and the Department Head. This approval can be revoked at any time.

# Upload a PDF file first, say HeiFinance_Organization_Chart.pdf
# Prompt Examples:

# Query 1: Who is the CEO and CFO?

# The CEO is Kenji Tan and the CFO is Li Wei.

# Query 2: How many country heads are there and who are they?

# There are six country heads: Lim Hock Chuan (Singapore), Jing Li (China), William Chan (Hong Kong), Siti Nurhaliza (Malaysia), Somchai Boonruang (Thailand), and Budi Santoso (Indonesia).

# Upload a PDF file first, say HeiFinance_Full_Directory_Complete.pdf -> heifinance_tables-formatted.json
# Prompt Examples:

# Length of All Employees Names: 128
# Length of Unique Names: 122
# Total number of employees from Singapore: 74
# Length of Repeated Names (in Singaopore employees): 6

# Repeated Names (in Singapore employees): ['Linda Tan', 'Marcus Sharma', 'James Poh', 'Sarah Wong', 'Chloe Ooi', 'Rajeev Lim']


# Query 1: Please retrieve the details for CFO and the names for staff working in Singapore. Count the number of Singapore staff.

# Here are the details you requested:

# CFO Details:

# EmployeeID: 2
# Name: Li Wei
# Job Title: Chief Financial Officer
# Department: Finance
# Contact: +65 6789-0002
# Email: li.wei@heifinance.com
# Office Location: Marina Bay Tower
# Country: Singapore
# Names of Staff Working in Singapore:

# Kenji Tan
# Li Wei
# David Lim
# Priya Sharma
# Ahmad Razak
# Michael Chen
# Sarah Wong
# Rajeev Singh
# Chloe Ng
# Jason Lee
# Evelyn Goh
# Lim Hock Chuan
# Kenji Ng
# Rajeev Razak
# Linda Lim
# David Wong
# James Poh
# Linda Wong
# Michael Seah
# Evelyn Sharma
# Marcus Sharma
# Li Chua
# Linda Lee
# David Wei
# Jason Lim
# Priya Teo
# Robert Hock
# Lim Hock
# Chloe Lim
# Michael Chua
# Evelyn Wei
# Li Goh
# Christopher Goh
# Patricia Teo
# Rajeev Yap
# Priya Razak
# Jennifer Poh
# Marcus Teo
# Linda Tan
# Linda Ng
# Chloe Ooi
# James Sharma
# James Poh Ah Kow
# Ahmad Hock
# Linda Ooi
# Barbara Goh
# Rajeev Ong
# David Koh
# Linda Razak
# Patricia Yap
# Chloe Ooi Ah Miow
# Rajeev Lim
# Kenji Lim
# Rajeev Lim Ah Choo
# Evelyn Lim
# Christopher Ong
# Jennifer Hock
# Priya Wei
# Sarah Wong Ah Tu
# Linda Tan Ah Sir
# Rajeev Chen
# Marcus Wei
# Marcus Tan
# Jennifer Yap
# Sarah Wei
# Barbara Lim
# Marcus Sharma Ah
# Jennifer Ong
# Sarah Goh
# Chloe Teo
# Jason Chua
# David Yap
# James Ng
# Lim Lim
# Total Number of Staff Working in Singapore: 74

# Query 2: Could you count the number of total employees in the phone directory? Show how you do the calculation.

# The total number of employees in the phone directory is 128. This was calculated by counting the number of entries in the provided employee data.

# Query 3: Who is working in Beijing Office?

# There are 9 employees working in the Beijing office. Their names are: Jing Li, Qiang Chen, Ling Tang, Yan Chen, Ming Zhou, Hui Zhao, Jing Zheng, Wei Wang, and Fang Li.

# Query 4: List out all employees with key-value pairs "Country": "Singapore". Count the length of such key-value pairs cases. 

# The employees with 'Country': 'Singapore' are as follows:

# {'EmployeeID': 1, 'Name': 'Kenji Tan', 'Job Title': 'Group Chief Executive Officer', 'Department': 'Executive Leadership', 'Contact': '+65 6789-0001', 'Email': 'kenji.tan@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 2, 'Name': 'Li Wei', 'Job Title': 'Chief Financial Officer', 'Department': 'Finance', 'Contact': '+65 6789-0002', 'Email': 'li.wei@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 3, 'Name': 'David Lim', 'Job Title': 'Chief Operating Officer', 'Department': 'Operations', 'Contact': '+65 6789-0003', 'Email': 'david.lim@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 4, 'Name': 'Priya Sharma', 'Job Title': 'Chief Information Officer', 'Department': 'Technology', 'Contact': '+65 6789-0004', 'Email': 'priya.sharma@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 5, 'Name': 'Ahmad Razak', 'Job Title': 'Chief Risk Officer', 'Department': 'Risk Management', 'Contact': '+65 6789-0005', 'Email': 'ahmad.razak@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 6, 'Name': 'Michael Chen', 'Job Title': 'Head of Institutional Banking', 'Department': 'Institutional Banking', 'Contact': '+65 6789-0006', 'Email': 'michael.chen@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 7, 'Name': 'Sarah Wong', 'Job Title': 'Head of Consumer Banking & Wealth Management', 'Department': 'Consumer Banking', 'Contact': '+65 6789-0007', 'Email': 'sarah.wong@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 8, 'Name': 'Rajeev Singh', 'Job Title': 'Head of Global Financial Markets', 'Department': 'Global Financial Markets', 'Contact': '+65 6789-0008', 'Email': 'rajeev.singh@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 9, 'Name': 'Chloe Ng', 'Job Title': 'Head of Strategic Marketing & Communications', 'Department': 'Marketing', 'Contact': '+65 6789-0009', 'Email': 'chloe.ng@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 10, 'Name': 'Jason Lee', 'Job Title': 'Head of Human Resources', 'Department': 'Human Resources', 'Contact': '+65 6789-0010', 'Email': 'jason.lee@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 11, 'Name': 'Evelyn Goh', 'Job Title': 'Head of Legal & Compliance', 'Department': 'Legal', 'Contact': '+65 6789-0011', 'Email': 'evelyn.goh@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 12, 'Name': 'Lim Hock Chuan', 'Job Title': 'Country Head - Singapore', 'Department': 'Regional Management', 'Contact': '+65 6789-1001', 'Email': 'lim.hockchuang@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 18, 'Name': 'Kenji Ng', 'Job Title': 'Senior Relationship Manager - Corporate Banking', 'Department': 'Institutional Banking', 'Contact': '+65-6789-0100', 'Email': 'kenji.ng@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 19, 'Name': 'Rajeev Razak', 'Job Title': 'Senior Relationship Manager - Corporate Banking', 'Department': 'Institutional Banking', 'Contact': '+65-6789-0101', 'Email': 'rajeev.razak@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 20, 'Name': 'Linda Lim', 'Job Title': 'Relationship Manager - Corporate Banking', 'Department': 'Institutional Banking', 'Contact': '+65-6789-0102', 'Email': 'linda.lim@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 22, 'Name': 'David Wong', 'Job Title': 'Relationship Manager - Corporate Banking', 'Department': 'Institutional Banking', 'Contact': '+65-6789-0104', 'Email': 'david.wong@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 23, 'Name': 'James Poh', 'Job Title': 'Credit Analyst - Corporate Banking', 'Department': 'Institutional Banking', 'Contact': '+65-6789-0105', 'Email': 'james.poh@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 24, 'Name': 'Linda Wong', 'Job Title': 'Credit Analyst - Corporate Banking', 'Department': 'Institutional Banking', 'Contact': '+65-6789-0106', 'Email': 'linda.wong@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 27, 'Name': 'Michael Seah', 'Job Title': 'Transaction Manager - Transaction Banking', 'Department': 'Institutional Banking', 'Contact': '+65-6789-0109', 'Email': 'michael.seah@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 29, 'Name': 'Evelyn Sharma', 'Job Title': 'Payment Operations Specialist - Transaction Banking', 'Department': 'Institutional Banking', 'Contact': '+65-6789-0111', 'Email': 'evelyn.sharma@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 30, 'Name': 'Marcus Sharma', 'Job Title': 'Branch Manager - Retail Banking', 'Department': 'Retail Banking', 'Contact': '+65-6789-0112', 'Email': 'marcus.sharma@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 32, 'Name': 'Li Chua', 'Job Title': 'Relationship Manager - Retail Banking', 'Department': 'Retail Banking', 'Contact': '+65-6789-0114', 'Email': 'li.chua@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 34, 'Name': 'Linda Lee', 'Job Title': 'Relationship Manager - Retail Banking', 'Department': 'Retail Banking', 'Contact': '+65-6789-0116', 'Email': 'linda.lee@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 36, 'Name': 'David Wei', 'Job Title': 'Customer Service Officer - Retail Banking', 'Department': 'Retail Banking', 'Contact': '+65-6789-0118', 'Email': 'david.wei@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 37, 'Name': 'Jason Lim', 'Job Title': 'Loan Officer - Retail Banking', 'Department': 'Retail Banking', 'Contact': '+65-6789-0119', 'Email': 'jason.lim@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 38, 'Name': 'Priya Teo', 'Job Title': 'Loan Officer - Retail Banking', 'Department': 'Retail Banking', 'Contact': '+65-6789-0120', 'Email': 'priya.teo@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 39, 'Name': 'Robert Hock', 'Job Title': 'Private Banker - Private Banking', 'Department': 'Private Banking', 'Contact': '+65-6789-0121', 'Email': 'robert.hock@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 40, 'Name': 'Lim Hock', 'Job Title': 'Private Banker - Private Banking', 'Department': 'Private Banking', 'Contact': '+65-6789-0122', 'Email': 'lim.hock@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 41, 'Name': 'Chloe Lim', 'Job Title': 'Wealth Manager - Private Banking', 'Department': 'Private Banking', 'Contact': '+65-6789-0123', 'Email': 'chloe.lim@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 43, 'Name': 'Michael Chua', 'Job Title': 'Investment Advisor - Private Banking', 'Department': 'Private Banking', 'Contact': '+65-6789-0125', 'Email': 'michael.chua@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 45, 'Name': 'Evelyn Wei', 'Job Title': 'Product Manager - Digital Banking', 'Department': 'Digital Banking', 'Contact': '+65-6789-0127', 'Email': 'evelyn.wei@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 46, 'Name': 'Li Goh', 'Job Title': 'Systems Analyst - Digital Banking', 'Department': 'Digital Banking', 'Contact': '+65-6789-0128', 'Email': 'li.goh@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 48, 'Name': 'Christopher Goh', 'Job Title': 'Trader - Trading', 'Department': 'Trading', 'Contact': '+65-6789-0130', 'Email': 'christopher.goh@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 49, 'Name': 'Patricia Teo', 'Job Title': 'Trader - Trading', 'Department': 'Trading', 'Contact': '+65-6789-0131', 'Email': 'patricia.teo@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 51, 'Name': 'Rajeev Yap', 'Job Title': 'Trading Analyst - Trading', 'Department': 'Trading', 'Contact': '+65-6789-0133', 'Email': 'rajeev.yap@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 56, 'Name': 'Priya Razak', 'Job Title': 'Analyst - Capital Markets', 'Department': 'Capital Markets', 'Contact': '+65-6789-0138', 'Email': 'priya.razak@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 57, 'Name': 'Jennifer Poh', 'Job Title': 'Senior Treasurer - Treasury', 'Department': 'Treasury', 'Contact': '+65-6789-0139', 'Email': 'jennifer.poh@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 58, 'Name': 'Marcus Teo', 'Job Title': 'Treasurer - Treasury', 'Department': 'Treasury', 'Contact': '+65-6789-0140', 'Email': 'marcus.teo@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 60, 'Name': 'Linda Tan', 'Job Title': 'Financial Planner - Financial Planning', 'Department': 'Financial Planning', 'Contact': '+65-6789-0142', 'Email': 'linda.tan@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 61, 'Name': 'Linda Ng', 'Job Title': 'Financial Planner - Financial Planning', 'Department': 'Financial Planning', 'Contact': '+65-6789-0143', 'Email': 'linda.ng@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 64, 'Name': 'Chloe Ooi', 'Job Title': 'Accountant - Financial Planning', 'Department': 'Financial Planning', 'Contact': '+65-6789-0146', 'Email': 'chloe.ooi@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 65, 'Name': 'James Sharma', 'Job Title': 'Treasurer - Treasury', 'Department': 'Treasury', 'Contact': '+65-6789-0147', 'Email': 'james.sharma@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 66, 'Name': 'James Poh Ah Kow', 'Job Title': 'Cash Manager - Treasury', 'Department': 'Treasury', 'Contact': '+65-6789-0148', 'Email': 'james.poh2@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 67, 'Name': 'Ahmad Hock', 'Job Title': 'Investment Officer - Treasury', 'Department': 'Treasury', 'Contact': '+65-6789-0149', 'Email': 'ahmad.hock@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 68, 'Name': 'Linda Ooi', 'Job Title': 'Senior Accountant - Accounting', 'Department': 'Accounting', 'Contact': '+65-6789-0150', 'Email': 'linda.ooi@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 69, 'Name': 'Barbara Goh', 'Job Title': 'Senior Accountant - Accounting', 'Department': 'Accounting', 'Contact': '+65-6789-0151', 'Email': 'barbara.goh@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 72, 'Name': 'Rajeev Ong', 'Job Title': 'Process Manager - Process Management', 'Department': 'Process Management', 'Contact': '+65-6789-0154', 'Email': 'rajeev.ong@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 73, 'Name': 'David Koh', 'Job Title': 'Operations Analyst - Process Management', 'Department': 'Process Management', 'Contact': '+65-6789-0155', 'Email': 'david.koh@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 74, 'Name': 'Linda Razak', 'Job Title': 'Operations Analyst - Process Management', 'Department': 'Process Management', 'Contact': '+65-6789-0156', 'Email': 'linda.razak@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 75, 'Name': 'Patricia Yap', 'Job Title': 'Quality Officer - Process Management', 'Department': 'Process Management', 'Contact': '+65-6789-0157', 'Email': 'patricia.yap@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 76, 'Name': 'Chloe Ooi Ah Miow', 'Job Title': 'Service Manager - Service Delivery', 'Department': 'Service Delivery', 'Contact': '+65-6789-0158', 'Email': 'chloe.ooi2@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 81, 'Name': 'Rajeev Lim', 'Job Title': 'Facilities Officer - Facilities', 'Department': 'Facilities Management', 'Contact': '+65-6789-0163', 'Email': 'rajeev.lim@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 84, 'Name': 'Kenji Lim', 'Job Title': 'Systems Administrator - Infrastructure', 'Department': 'Infrastructure', 'Contact': '+65-6789-0166', 'Email': 'kenji.lim@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 85, 'Name': 'Rajeev Lim Ah Choo', 'Job Title': 'Network Engineer - Infrastructure', 'Department': 'Infrastructure', 'Contact': '+65-6789-0167', 'Email': 'rajeev.lim2@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 86, 'Name': 'Evelyn Lim', 'Job Title': 'Application Manager - Applications', 'Department': 'Applications', 'Contact': '+65-6789-0168', 'Email': 'evelyn.lim@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 89, 'Name': 'Christopher Ong', 'Job Title': 'Systems Analyst - Applications', 'Department': 'Applications', 'Contact': '+65-6789-0171', 'Email': 'christopher.ong@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 92, 'Name': 'Jennifer Hock', 'Job Title': 'Compliance Officer - Security', 'Department': 'Security', 'Contact': '+65-6789-0174', 'Email': 'jennifer.hock@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 94, 'Name': 'Priya Wei', 'Job Title': 'Risk Analyst - Credit Risk', 'Department': 'Credit Risk', 'Contact': '+65-6789-0176', 'Email': 'priya.wei@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 96, 'Name': 'Sarah Wong Ah Tu', 'Job Title': 'Credit Officer - Credit Risk', 'Department': 'Credit Risk', 'Contact': '+65-6789-0178', 'Email': 'sarah.wong2@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 101, 'Name': 'Linda Tan Ah Sir', 'Job Title': 'Risk Officer - Operational Risk', 'Department': 'Operational Risk', 'Contact': '+65-6789-0183', 'Email': 'linda.tan2@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 102, 'Name': 'Rajeev Chen', 'Job Title': 'Recruitment Manager - Recruitment', 'Department': 'Recruitment', 'Contact': '+65-6789-0184', 'Email': 'rajeev.chen@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 104, 'Name': 'Marcus Wei', 'Job Title': 'Recruiter - Recruitment', 'Department': 'Recruitment', 'Contact': '+65-6789-0186', 'Email': 'marcus.wei@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 105, 'Name': 'Marcus Tan', 'Job Title': 'HR Coordinator - Recruitment', 'Department': 'Recruitment', 'Contact': '+65-6789-0187', 'Email': 'marcus.tan@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 107, 'Name': 'Jennifer Yap', 'Job Title': 'Training Specialist - Learning & Development', 'Department': 'Learning & Development', 'Contact': '+65-6789-0189', 'Email': 'jennifer.yap@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 109, 'Name': 'Sarah Wei', 'Job Title': 'ER Manager - Employee Relations', 'Department': 'Employee Relations', 'Contact': '+65-6789-0191', 'Email': 'sarah.wei@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 115, 'Name': 'Barbara Lim', 'Job Title': 'Compliance Officer - Compliance', 'Department': 'Compliance', 'Contact': '+65-6789-0197', 'Email': 'barbara.lim@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 116, 'Name': 'Marcus Sharma Ah', 'Job Title': 'Compliance Officer - Compliance', 'Department': 'Compliance', 'Contact': '+65-6789-0198', 'Email': 'marcus.sharma2@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 119, 'Name': 'Jennifer Ong', 'Job Title': 'Regulatory Officer - Regulatory', 'Department': 'Regulatory', 'Contact': '+65-6789-0201', 'Email': 'jennifer.ong@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 121, 'Name': 'Sarah Goh', 'Job Title': 'Marketing Executive - Marketing', 'Department': 'Marketing', 'Contact': '+65-6789-0203', 'Email': 'sarah.goh@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 122, 'Name': 'Chloe Teo', 'Job Title': 'Marketing Executive - Marketing', 'Department': 'Marketing', 'Contact': '+65-6789-0204', 'Email': 'chloe.teo@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 123, 'Name': 'Jason Chua', 'Job Title': 'Digital Marketing Specialist - Marketing', 'Department': 'Marketing', 'Contact': '+65-6789-0205', 'Email': 'jason.chua@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 126, 'Name': 'David Yap', 'Job Title': 'PR Specialist - Communications', 'Department': 'Communications', 'Contact': '+65-6789-0208', 'Email': 'david.yap@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 127, 'Name': 'James Ng', 'Job Title': 'CX Manager - Customer Experience', 'Department': 'Customer Experience', 'Contact': '+65-6789-0209', 'Email': 'james.ng@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# {'EmployeeID': 128, 'Name': 'Lim Lim', 'Job Title': 'CX Specialist - Customer Experience', 'Department': 'Customer Experience', 'Contact': '+65-6789-0210', 'Email': 'lim.lim@heifinance.com', 'Office Location': 'Marina Bay Tower', 'Country': 'Singapore'}
# The count of employees with 'Country': 'Singapore' is 74.

# Upload a PDF file first, say HeiFinance Bank Product Fact Sheet.pdf
# Prompt Examples:

# What is the minimum deposit for SavingsPlus?

# The minimum deposit requirement for the SavingsPlus Account is SGD 500. [Source 4]

# If I refinance my existing mortgage, what is my estimated monthly repayment under the HomeFlex Loan floating package?

# I cannot answer your question. The provided text does not contain enough information to estimate your monthly repayment for a refinanced mortgage under the HomeFlex Loan floating package. While it mentions the floating rate is pegged to 3M SORA plus a spread of 0.80% to 1.20% and rates reset quarterly [Source 1, Source 2], it does not provide the current 3M SORA rate or your specific spread, which are necessary to calculate the monthly repayment.

# Hi, can you tell me what the minimum deposit is for the HeiFinance SavingsPlus Account, and whether I can get bonus interest if I only spend $400 monthly on my credit card?

# The minimum deposit requirement for the HeiFinance SavingsPlus Account is SGD 500. [Source 2]
# To receive bonus interest for eligible debit or credit card spending, you need to spend at least SGD 500 per month. Therefore, spending $400 monthly on your credit card would not qualify for the bonus interest in that category. [Source 1]

# Query 1:
# What is the minimum deposit for heifinance saving plus account?

# The minimum deposit requirement for the HeiFinance SavingsPlus Account is SGD 500 [Source 2].

# Query 2:
# Hi, can you tell me what the minimum deposit is for the heifinance savingsplus account and whether i can get bonus interest if i only spend $400 monthly on my credit card?

# The minimum deposit requirement for the HeiFinance SavingsPlus Account is SGD 500 [Source 2].
# To receive bonus interest for eligible debit or credit card spending, a minimum of SGD 500 needs to be spent monthly [Source 2]. Therefore, if you only spend $400 monthly on your credit card, you would not qualify for this specific bonus interest component.

# Query 3:
# How much cashback on the visa platinum card can i get if i spend 1000 on groceries, 800 on dining and 900 on online purchases?

# To calculate the cashback, we need to break down the spending according to the card's rewards program.

# Groceries and Dining: These categories earn 3% cashback.
# Total spent on groceries and dining = SGD 1000 + SGD 800 = SGD 1800
# Cashback on groceries and dining = 3% of SGD 1800 = SGD 54
# Online Purchases: These fall under "all other retail transactions" and earn 1% cashback.
# Cashback on online purchases = 1% of SGD 900 = SGD 9
# Total Cashback: SGD 54 + SGD 9 = SGD 63
# The monthly cashback cap is SGD 80. Since SGD 63 is below this cap, the total cashback earned is SGD 63. [Source 1]

# Query 4:
# What is the difference between floating and fixed loan rate offered by heifinance?
# The HeiFinance HomeFlex Loan offers two packages: a Fixed Rate Package and a Floating Rate Package.

# Fixed Rate Package:

# The interest rate is fixed for the first 3 years.
# After this fixed period, the rate reverts to the HeiFinance Board Rate (currently 3.5% p.a.) minus a customer discount.
# This package provides certainty in monthly installments, making it suitable for customers who prefer predictability [Source 1].

# Floating Rate Package:

# The interest rate is pegged to 3M SORA plus a spread ranging between 0.80% and 1.20%.
# The rates reset quarterly according to SORA movement.
# This package is suitable for customers who are comfortable with fluctuations in the hope of potentially lower costs [Source 1, Source 4].

# Query 5:
# If i refinance my existing mortgage, what is my estimated monthly repayment under the homeflex loan floating package?

# I don't know. The provided context does not contain information about the estimated monthly repayment for refinancing an existing mortgage under the HomeFlex Loan floating package. It does mention that the Floating Rate Package is pegged to 3M SORA plus a spread ranging between 0.80% and 1.20%, and rates reset quarterly [Source 1, Source 2]. There is also a refinancing subsidy of up to SGD 2,000 for legal and valuation fees for refinancing customers [Source 1].



# CTRL+C

# Pressed CTRL+C in terminal to stop server:

# Keyboard interruption in main thread... closing server.
# (base) 
# ERIC NG@LAPTOP-MT5ND6S9 MINGW64 e/source/tgc-cp1
# $