# Healthcare Claims Cost Analysis

## Overview

This project analyzes healthcare claims data from Analyst Builder (https://www.analystbuilder.com/projects/healthcare-claims-where-is-the-money-going-TVHLQ?tab=overview) to identify where costs are concentrated and where the organization is losing money. The analysis examines spending by claim type, procedure codes, diagnosis codes, and member-level costs.

This project demonstrates skills in SQL (data querying, aggregation, filtering), R (ggplot2, dplyr), and healthcare data analysis.

## Business Question

Which claim types are the most expensive?

Which CPT and ICD codes drive the highest spending?

Which members account for the largest share of total costs?

How do billed amounts compare to paid amounts?

## Data

* `claims` — 447 claims across 100 members (2 claims removed during data cleaning)


## Key Findings

* **Inpatient claims** account for $1.09M (70% of total paid)
* **Top CPT code** (67890) alone accounts for $204K in spending
* **Top 10 members** account for disproportionate spending, with Member 6 and Member 32 each exceeding $40K
* **Payment ratio** is lowest for inpatient (74%) and highest for lab (91%)
* **Total billed**: $2,061,985 | Total paid: $1,550,565 (75% payment ratio)

## Figures
<img src="images/Claim Type by Paid and Billed Amounts.jpeg" width="800" height="800">
<img src="images/Ratio by Claim Type.jpeg" width="800" height="800">
<img src="images/Top 10 ICD Codes by Paid Amount.jpeg" width="800" height="800">
<img src="images/Top 10 CPT Codes by Paid Amount.jpeg" width="800" height="800">
<img src="images/Top 10 Member Level Claims by Claim Type.jpeg" width="800" height="800">

## Discussion

The concentration of spending in a small number of high-cost members indicates an area for change. Inpatient claims dominate spending at 70% of total paid amounts. Identifying ICD and CPT codes with high spending can help decrease total inpatient paid amounts.

## Tools Used

SQL (SQLite), R (ggplot2)
