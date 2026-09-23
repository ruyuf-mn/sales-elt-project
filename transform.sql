-- ============================================
-- Sales Data Transformation (SQL)
-- Combines: NULL handling, deduplication, 
-- date conversion, and revenue ranking
-- ============================================

CREATE VIEW Clean_Sales AS
WITH null_price AS (
    -- Replace missing prices with 0
    SELECT *, COALESCE("Unit Price", 0) AS clean_price
    FROM raw_sales
),
no_duplicates AS (
    -- Remove duplicate transactions (excluding unique Transaction ID)
    SELECT DISTINCT ON ("Product Name", "Date", "Units Sold", clean_price, "Region", "Payment Method") *
    FROM null_price
),
proper_date AS (
    -- Convert date from text to proper date type
    SELECT *, TO_DATE("Date", 'MM/DD/YYYY') AS Date_Fixed
    FROM no_duplicates
),
Rnaked AS (
    -- Rank products by revenue within each category
    SELECT *, RANK() OVER (PARTITION BY "Product Category" ORDER BY "Total Revenue" DESC) AS Rnk
    FROM proper_date
)
SELECT * FROM Rnaked;

-- Query the final clean analysis-ready dataset
SELECT * FROM Clean_Sales;