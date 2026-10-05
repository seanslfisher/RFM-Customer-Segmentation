# RFM Customer Segmentation

An end-to-end customer segmentation project using SQL in Google BigQuery and Tableau to analyze purchasing behavior and identify actionable customer segments.

## Project Overview

This project uses RFM (Recency, Frequency, Monetary) analysis to evaluate customer purchasing behavior and group customers into meaningful segments.

The analysis was performed in Google BigQuery using SQL, and the results were visualized in an interactive Tableau dashboard.

## Tools

- Google BigQuery
- SQL
- Tableau

## Analysis

The project calculates three key customer metrics:

- **Recency:** How recently a customer made a purchase
- **Frequency:** How often a customer made purchases
- **Monetary:** How much a customer spent

Customers were then grouped into segments based on their RFM scores, including:

- Champions
- Loyal VIPs
- At Risk
- Other customer segments

## Dashboard

![RFM Customer Segmentation Dashboard](Customer%20Segmentation%20Analysis.png)

## Files

| File | Description |
|---|---|
| `rfm_analysis.sql` | SQL queries used for the RFM analysis in BigQuery |
| `RFM Segmentation Dashboard.twb` | Tableau workbook containing the dashboard |
| `Customer Segmentation Analysis.png` | Preview of the Tableau dashboard |

## Key Takeaway

The analysis demonstrates how customer transaction data can be transformed into actionable segments using SQL and communicated through an interactive Tableau dashboard.
