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

# Query 2: What are the key points discussed in the document?

# Query 3: Can you explain the main arguments presented in the PDF?

# Query 4: What is the working hours?

# Query 5: What is the procedure for handling complaints?

# Query 6: What is the company's policy on outside employment?


# Upload a PDF file first, say HeiFinance_Organization_Chart.pdf
# Prompt Examples:

# Query 1: Who is the CEO and CFO?

# Query 2: How many country heads are there and what are them?

# Upload a PDF file first, say HeiFinance_Full_Directory_Complete.pdf -> heifinance_tables-formatted.json
# Prompt Examples:

# Length of All Employees Names: 128
# Length of Unique Names: 122
# Total number of employees from Singapore: 74
# Length of Repeated Names (in Singaopore employees): 6

# Repeated Names (in Singapore employees): ['Linda Tan', 'Marcus Sharma', 'James Poh', 'Sarah Wong', 'Chloe Ooi', 'Rajeev Lim']


# Query 1: Please retrieve the details for CFO and the names for staff working in Singapore. Count the number of Singapore staff.

# Query 2: Could you count the number of total employees in the phone directory? Show how you do the calculation.

# Query 3: Count the number with key-value pairs "Country": "Singapore".

# Query 4: List out all employees with key-value pairs "Country": "Singapore". Count the length of such key-value pairs cases. 


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