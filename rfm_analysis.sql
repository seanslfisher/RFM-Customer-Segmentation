
CREATE OR REPLACE TABLE `rfm-analysis-490500.sales.sales_2025` AS
SELECT OrderID, CustomerID, OrderDate, ProductType, OrderValue FROM `rfm-analysis-490500.sales.sales202501`
UNION ALL SELECT OrderID, CustomerID, OrderDate, ProductType, OrderValue FROM `rfm-analysis-490500.sales.sales202502`
UNION ALL SELECT OrderID, CustomerID, OrderDate, ProductType, OrderValue FROM `rfm-analysis-490500.sales.sales202503`
UNION ALL SELECT OrderID, CustomerID, OrderDate, ProductType, OrderValue FROM `rfm-analysis-490500.sales.sales202504`
UNION ALL SELECT OrderID, CustomerID, OrderDate, ProductType, OrderValue FROM `rfm-analysis-490500.sales.sales202505`
UNION ALL SELECT OrderID, CustomerID, OrderDate, ProductType, OrderValue FROM `rfm-analysis-490500.sales.sales202506`
UNION ALL SELECT OrderID, CustomerID, OrderDate, ProductType, OrderValue FROM `rfm-analysis-490500.sales.sales202507`
UNION ALL SELECT OrderID, CustomerID, OrderDate, ProductType, OrderValue FROM `rfm-analysis-490500.sales.sales202508`
UNION ALL SELECT OrderID, CustomerID, OrderDate, ProductType, OrderValue FROM `rfm-analysis-490500.sales.sales202509`
UNION ALL SELECT OrderID, CustomerID, OrderDate, ProductType, OrderValue FROM `rfm-analysis-490500.sales.sales202510`
UNION ALL SELECT OrderID, CustomerID, OrderDate, ProductType, OrderValue FROM `rfm-analysis-490500.sales.sales202511`
UNION ALL SELECT OrderID, CustomerID, OrderDate, ProductType, OrderValue FROM `rfm-analysis-490500.sales.sales202512`; 


CREATE OR REPLACE VIEW `rfm-analysis-490500.sales.rfm_metrics` 
AS
WITH rfm AS (
  SELECT 
    CustomerID,
    MAX(OrderDate) AS last_order_date,
    DATE_DIFF(DATE('2026-03-06'), MAX(OrderDate), DAY) AS recency, 
    COUNT(*) AS frequency,
    SUM(OrderValue) AS monetary
  FROM `rfm-analysis-490500.sales.sales_2025`
  GROUP BY CustomerID
)
SELECT 
  rfm.*,
  ROW_NUMBER() OVER(ORDER BY recency ASC) AS r_rank,
  ROW_NUMBER() OVER(ORDER BY frequency DESC) AS f_rank,
  ROW_NUMBER() OVER(ORDER BY monetary DESC) AS m_rank
FROM rfm;


CREATE OR REPLACE VIEW `rfm-analysis-490500.sales.rfm_scores` 
AS
SELECT *, 
  NTILE(10) OVER(ORDER BY r_rank DESC) AS r_score, 
  NTILE(10) OVER(ORDER BY f_rank DESC) AS f_score, 
  NTILE(10) OVER(ORDER BY m_rank DESC) AS m_score
FROM `rfm-analysis-490500.sales.rfm_metrics`;


CREATE OR REPLACE VIEW `rfm-analysis-490500.sales.rfm_totalscores` 
AS
SELECT
  CustomerID,recency, frequency, monetary, r_score, f_score, m_score, 
  ( r_score+ f_score +m_score) AS rfm_total_score

FROM `rfm-analysis-490500.sales.rfm_scores`
ORDER BY rfm_total_score DESC;

CREATE OR REPLACE TABLE `rfm-analysis-490500.sales.rfm_segments_final`
AS 
SELECT 
  CustomerID,recency, frequency, monetary, r_score, f_score, m_score,rfm_total_score,
  CASE
    WHEN rfm_total_score >= 28 THEN 'Champions'
    WHEN rfm_total_score >= 24 THEN 'Loyal VIPs'
    WHEN rfm_total_score >= 20 THEN 'Potential Loyalists'
    WHEN rfm_total_score >= 16 THEN 'Promising'
    WHEN rfm_total_score >= 12 THEN 'Engaged'
    WHEN rfm_total_score >= 8 THEN 'Req Attention'
    WHEN rfm_total_score >= 4 THEN 'At Risk'
    ELSE "LOST/Inactive"
END AS rmf_segment
FROM `rfm-analysis-490500.sales.rfm_totalscores`
ORDER BY rfm_total_score DESC;


