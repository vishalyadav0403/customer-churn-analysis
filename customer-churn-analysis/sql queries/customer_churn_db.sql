---------------------------------------------------
-- View Data
---------------------------------------------------

SELECT * 
FROM public.customer_churn
LIMIT 10;

---------------------------------------------------
-- 1. Overall Churn Rate
---------------------------------------------------

SELECT 
    ROUND((100 * AVG("Churn Value"))::numeric, 2) AS churn_rate
FROM public.customer_churn;

---------------------------------------------------
-- 2. Churn by Contract Type
---------------------------------------------------

SELECT 
    "Contract",
    COUNT(*) AS total_customers,
    SUM("Churn Value") AS churned_customers,
    ROUND((100 * AVG("Churn Value"))::numeric, 2) AS churn_rate
FROM public.customer_churn
GROUP BY "Contract"
ORDER BY churn_rate DESC;

---------------------------------------------------
-- 3. Revenue at Risk
---------------------------------------------------

SELECT 
    ROUND(SUM("Monthly Charges")::numeric, 2) AS revenue_at_risk
FROM public.customer_churn
WHERE "Churn Value" = 1;

---------------------------------------------------
-- 4. Average Tenure by Churn
---------------------------------------------------

SELECT
    "Churn Value",
    ROUND(AVG("Tenure Months")::numeric, 2) AS avg_tenure
FROM public.customer_churn
GROUP BY "Churn Value";

---------------------------------------------------
-- 5. Internet Service Risk Analysis
---------------------------------------------------

SELECT 
    "Internet Service",
    COUNT(*) AS customers,
    ROUND((100 * AVG("Churn Value"))::numeric, 2) AS churn_rate
FROM public.customer_churn
GROUP BY "Internet Service"
ORDER BY churn_rate DESC;

---------------------------------------------------
-- 6. High-Risk Customer Segment
---------------------------------------------------

SELECT
    "Contract",
    "Payment Method",
    COUNT(*) AS customers,
    ROUND((100 * AVG("Churn Value"))::numeric, 2) AS churn_rate
FROM public.customer_churn
WHERE "Tenure Months" < 12
GROUP BY "Contract", "Payment Method"
ORDER BY churn_rate DESC;