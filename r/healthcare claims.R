# install packages
if (!require("pacman")) install.packages("pacman")

# install additional packages
pacman::p_load(
  rio,
  here,
  tidyverse,
  ggplot2,
  dplyr,
  ggthemes,
  gtsummary,
  flextable,
  skimr
)

# set root directory and make into object
root_dir <- "data"

# import 
claim_breakdown <- rio::import(here::here(root_dir, "claim type cost breakdown.csv"))
highest_cost_members <- rio::import(here::here(root_dir, "highest cost members by claim type.csv"))
icd <- rio::import(here::here(root_dir, "top 10 icd codes by total paid.csv"))
cpt <- rio::import(here::here(root_dir, "top 10 cpt codes by total paid amount.csv"))
ratio <- rio::import(here::here(root_dir, "ratio by claim type.csv"))

# reformat data
data_long <- claim_breakdown %>%
  pivot_longer(cols = c(total_pd_amt, total_billed_amt),
               names_to = "Paid_Billed",
               values_to = "Total_Amounts")

# visualize
ggplot(data_long, aes(x = claim_type, y = Total_Amounts, fill = Paid_Billed)) +
  geom_col(width = 0.7, position = "dodge") +
  scale_y_continuous(labels = scales::dollar) + 
  labs(title = "Claim Summary",
       x = "Claim Type",
       y = "Total",
       fill = "Amount Type") +
  scale_fill_manual(
    labels = c("total_pd_amt" = "Paid", "total_billed_amt" = "Billed"),
    values = c("total_pd_amt" = "#F87660", "total_billed_amt" = "#00BFC4")) + 
  theme_minimal() + coord_flip()

# number of claims by type
ggplot(claim_breakdown, aes(x = reorder(`claim_type`, -total_claims), y = total_claims)) +
  geom_bar(stat = "identity", width = 0.5, fill = "steelblue") +
  labs(title = "Total Claims by Type",
       x = "Type",
       y = "Number of Claims") +
  theme_minimal() + theme(legend.position = "none")

# claims by most expensive
ggplot(highest_cost_members, aes(x = factor(member_id), y = total_pd_amt, fill = `claim_type`)) +
  geom_col(width = 0.7) +
  scale_y_continuous(labels = scales::dollar) + 
  scale_fill_viridis_d() +
  labs(title = "Top 10 Member Level Claims by Claim Type",
       x = "Member ID",
       y = "Total",
       fill = "Claim Type") +
  # labels = c("total_pd_amt" = "Paid", "total_billed_amt" = "Billed"),
  #values = c("total_pd_amt" = "#F87660", "total_billed_amt" = "#00BFC4")) + 
  theme_minimal()

# top 10 icd codes by paid amount
ggplot(icd, aes(x =reorder(icd_code, total_pd_amt), y = total_pd_amt)) +
  geom_bar(stat = "identity", width = 0.5, fill = "purple") +
  scale_y_continuous(labels = scales::dollar) + 
  labs(title = "Top 10 ICD Codes by Paid Amount",
       x = "Code",
       y = "Paid Amount") +
  theme_minimal() + theme(legend.position = "none")

# top 10 cpt codes by paid amount
ggplot(cpt, aes(x =reorder(cpt_code, total_pd_amt), y = total_pd_amt)) +
  geom_bar(stat = "identity", width = 0.5, fill = "blue") +
  scale_y_continuous(labels = scales::dollar) + 
  labs(title = "Top 10 CPT Codes by Paid Amount",
       x = "Code",
       y = "Paid Amount") +
  theme_minimal() + theme(legend.position = "none")

# paid/bill ratio for claim type
ggplot(ratio, aes(x = reorder(claim_type, ratio), y = ratio)) +
  geom_bar(stat = "identity", width = 0.5, fill = "forestgreen") +
  labs(title = "Ratio by Claim Type",
       x = "Type",
       y = "Ratio") +
  theme_minimal() + theme(legend.position = "none")
