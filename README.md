
# TrueRootBio ESG Data Analysis

An end-to-end data engineering and analytics pipeline implementing a Medallion architecture to ingest, clean, and standardize global multi-scope GHG emissions for TrueRootBio—a simulated agribusiness entity built to mirror enterprise corporate sustainability compliance frameworks.

# Executive Overview
TrueRootBio is a fabricated AgriScience company. In this analysis, I discovered that Scope 3 Emissions (Value Chain Emissions) make up over 98% of our emissions (see charts below), which are "over budget" and will not meet our 2030 mandates.

<img width="1305" height="717" alt="Image" src="https://github.com/user-attachments/assets/1ab386cf-e3b2-47b3-b883-bc7207ddae73" />

The data also showed that several farms were giving faulty fuel readings (see below). 

<img width="1287" height="705" alt="Image" src="https://github.com/user-attachments/assets/9ae64344-37e4-4c5a-8706-f59579d77e4e" />



I recommend that the company take the following actions:
1. Corporate Logistics must immediately address the Scope 3 emissions. 
2. Deploy an Administrative IT Triage to the 5 farms with negatvie fuel data.
3. Immediate operational training refresher for field supervisors at those specific 5 farms, because missing fuel data could mean a human process failure.



# Business Problem
This analysis set out to answer the questions 
1) Are our global operations on track to meet the 2030 client mandates within scope 1 - Direct Emissions, scope 2 - Indirect Purchased Energy, and scope 3 - Value Chain Emissions?
2) Where are our data quality issues hiding our true carbon liabilities?

# Methodology
For this analysis, I simulated the Medallion architecture methodology for the ETL. I generated faux data using python scripts to generate raw .csv files and brought those into my data store (bronze), prepared the data with SQL and created cleaned-up views of the data in a SQLite DB environment(silver), and then I combined the data into an aggregate fact table, also using SQL (gold). I used Power BI to generate the reports and visualizations.

## A Few Notes on the Data Governance & Pipeline Rules

### The Quarantine Filter Logic (Silver)
To ensure absolute data completeness for ESG auditors, the pipeline splits incoming Scope 1 tractor telemetry. Rows where `fuel_consumed IS NULL`, `fuel_consumed = 0`, or `fuel_consumed < 0` are dynamically flagged with granular error messages and preserved physically in `quarantine_field_operations` for site-specific administrative triage.

### Scope 3 Short-Ton Normalization Math
Logistics datasets arrive with chaotic, mixed structural weights. The script dynamically routes records through an executive scale matrix inside a database Common Table Expression (CTE) to output **Ton-Miles** prior to emission mapping:
*   **Pounds (lbs):** Divided by `2,000.0`
*   **Kilograms (kg):** Divided by `907.184`
*   **Metric Tons (MT):** Multiplied by `1.10231`

# Skills
SQL (CASE Statements, CTEs, nested queries), ETL, Power BI, DAX, calculated columns, data visualization, data modeling, business insights

# Results and Business Recommendations
1. Immediately address the Scope 3 emissions by re-negotiating third-party freight contracts. We should institute a mandatory carbon-efficiency tiering system for carriers, shifting volume preference toward freight partners utilizing alternative fuel fleets or optimized rail lanes to lower our global Ton-Mile intensity.
2. There are 15 instances in our fact table of bad fuel records, coming from 5 farms. Of those, 5 of them have negative fuel data. This points to faulty hardware telemetry. We must immediately dispatch a regional operations technician to re-calibrate or replace the physical fuel flow-rate sensors on the tractor fleet at those farm locations to halt the injection of corrupt data. Those locations are Iowa_North, Kyiv_Obl, Mato_Graso, Illinois_East, and Indiana_West.
3. The same 5 farms also have records with no fuel data, so this indicates a human process failure rather than a hardware malfunction. We recommend launching an immediate operational training refresher for field supervisors at these specific locations to standardize the nightly upload routines and enforce compliance with data completeness protocols.
