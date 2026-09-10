------------Claim Type Cost Breakdown-----------------

--ID distinct cpt codes
SELECT DISTINCT cpt_code
FROM claims;

--remove unnecessary codes
DELETE FROM claims
WHERE cpt_code IN ('simples', 'pher');

--find total number of claims
SELECT COUNT(*)
FROM claims;

--find distinct member count from claims
SELECT COUNT (DISTINCT member_id) AS total_members
FROM claims;

--find distinct claim type
SELECT DISTINCT claim_type AS distinct_claims
FROM claims;

--find overall percent of total paid by claim type
SELECT claim_type, SUM(paid_amount) as total_paid, SUM(billed_amount) as total_billed, COUNT(claim_id) as total_claims,
	ROUND(SUM(paid_amount) * 100.0 / SUM(SUM(paid_amount)) OVER (),
	2)
		AS pct_of_total_paid
FROM claims
GROUP BY claim_type
ORDER BY pct_of_total_paid DESC;

-------------------CPT/ICD Cost Drivers--------------------
--find top 10 CPT codes by total paid amount

CREATE VIEW cpt_summary AS
SELECT SUM(paid_amount) AS total_pd_amt, cpt_code
FROM claims
GROUP BY cpt_code;

---use cpt summary to order by top 10
SELECT total_pd_amt, cpt_code
FROM cpt_summary
ORDER BY total_pd_amt DESC LIMIT 10;


CREATE VIEW icd_summary AS
SELECT SUM(paid_amount) AS total_pd_amt, icd_code
FROM claims
GROUP BY icd_code;

---use icd summary to order by top 10
SELECT total_pd_amt, icd_code
FROM icd_summary
ORDER BY total_pd_amt DESC LIMIT 10;

---number of occurrences of cpt_code
CREATE VIEW cpt AS
SELECT cpt_code, COUNT(cpt_code) AS distinct_code, SUM(paid_amount) AS total_amt
FROM claims
GROUP BY cpt_code
ORDER BY total_amt DESC;

--avg paid per claim
SELECT cpt_code, (total_amt/distinct_code) AS avg_claim_pay
FROM cpt
ORDER BY avg_claim_pay DESC LIMIT 10;

------------Member Level Analysis-------------------

---total paid amount per member
SELECT member_id, SUM(paid_amount) AS total_pd_amt
FROM claims
GROUP BY member_id;

---top 10 highest cost members
CREATE VIEW highest_paying_members AS
SELECT member_id, SUM(paid_amount) AS total_pd_amt
FROM claims
GROUP BY member_id 
ORDER BY total_pd_amt DESC LIMIT 10;

---top 10 highest cost members by claim type
SELECT member_id, claim_type, SUM(paid_amount) AS total_pd_amt
FROM claims
WHERE member_id IN (SELECT member_id FROM highest_paying_members)
GROUP BY member_id
ORDER BY member_id DESC
LIMIT 10;

---------Billed vs Paid Ratio-----------------
---find ratio for each claim type 
SELECT claim_type, SUM(paid_amount) as paid, SUM(billed_amount) as bill, (SUM(paid_amount)/SUM(billed_amount)) AS ratio
FROM claims
GROUP BY claim_type
ORDER BY ratio DESC;

---find ratio for each provider
SELECT claim_type, provider_id, SUM(paid_amount) as paid, SUM(billed_amount) as bill, (SUM(paid_amount)/SUM(billed_amount)) AS ratio
FROM claims
GROUP BY provider_id, claim_type
ORDER BY provider_id;

---find ratio for each cpt code
SELECT claim_type, cpt_code, SUM(paid_amount) as paid, SUM(billed_amount) as bill, (SUM(paid_amount)/SUM(billed_amount)) AS ratio
FROM claims
GROUP BY  claim_type, cpt_code
ORDER BY ratio DESC;
