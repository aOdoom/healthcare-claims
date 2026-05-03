# Healthcare Claims Cost Analysis

## Overview

This project analyzes healthcare claims data to identify where costs are concentrated and where the organization is losing money. The analysis examines spending by claim type, procedure codes, diagnosis codes, and member-level costs.

This project demonstrates skills in SQL (data querying, aggregation, filtering), R (ggplot2, dplyr), and healthcare data analysis.

## Business Question

Where is the organization bleeding money, and what drives the highest costs?

## Data

* `claims` — 447 claims across 100 members (2 claims removed during data cleaning)
* Total billed: $2,061,985 | Total paid: $1,550,565 (75% payment ratio)

## Key Findings

* **Inpatient claims** account for $1.09M (70% of total paid)
* **Top CPT code** (67890) alone accounts for $204K in spending
* **Top 10 members** account for disproportionate spending, with Member 6 and Member 32 each exceeding $40K
* **Payment ratio** is lowest for inpatient (74%) and highest for lab (91%)

## Figures

![Claim Type by Paid and Billed Amounts](images/Claim%20Type%20by%20Paid%20and%20Billed%20Amounts.jpeg)

![Ratio by Claim Type](images/Ratio%20by%20Claim%20Type.jpeg)

![Top 10 CPT Codes by Paid Amount](images/Top%2010%20CPT%20Codes%20by%20Paid%20Amount.jpeg)

![Top 10 ICD Codes by Paid Amount](images/Top%2010%20ICD%20Codes%20by%20Paid%20Amount.jpeg)

![Top 10 Member Level Claims by Claim Type](images/Top%2010%20Member%20Level%20Claims%20by%20Claim%20Type.jpeg)


## Discussion

Inpatient claims dominate spending at 70% of total paid amounts. The concentration of spending in a small number of high-cost members indicates an area for change.

## Tools Used

SQL (SQLite), R (ggplot2)
