# Sales Data ELT Pipeline
An end-to-end ELT (Extract, Load, Transform) data pipeline designed to ingest raw e-commerce sales data, load it into a PostgreSQL cloud database, and transform it using advanced SQL for downstream analysis.

# Project Architecture & Workflow:
 
1. Extract & Load (Python): 
   - Reads raw data from `Online Sales Data-m.csv`.
   - Performs initial data profiling (`info()`, `describe()`, duplicate check).
   - Ingests raw data directly into the `raw_sales` table in PostgreSQL.
2. Transform (SQL):
   - Processes data inside the database using CTEs (Common Table Expressions).
   - Generates a production-ready view (`Clean_Sales`) for analytics.

# Tech Stack

- Language: Python, SQL
- Database: PostgreSQL (Hosted on Supabase)
- Libraries: Pandas, SQLAlchemy, psycopg2-binary

---

# SQL Transformation Steps

The transformation step (`transform.sql`) handles data cleaning and enrichment inside PostgreSQL through a structured pipeline:

1. `null_price` (Null Handling): Replaces missing unit prices with `0` using `COALESCE`.
2. `no_duplicates` (Deduplication): Removes duplicate transaction records using `DISTINCT ON`.
3. `proper_date` (Data Type Conversion): Converts text-formatted dates (`MM/DD/YYYY`) into actual `DATE` types using `TO_DATE`.
4. `Rnaked` (Business Analytics): Ranks products by revenue within each product category using `RANK() OVER (PARTITION BY ... ORDER BY ...)`.

---

# How to Run the Project

1. Prerequisites
Ensure you have Python installed, then install the required dependencies:
```bash
pip install psycopg2-binary sqlalchemy pandas
```
2. Extract & Load Data
Run the ingestion script to load the raw data into your database:
```bash
python extract_load.py
```

3. Run Transformations
Execute the `transform.sql` script in your SQL client or Supabase Query Editor to create the analytical view:
```sql
-- Creates the clean view
\i transform.sql

-- Query the analysis-ready dataset
SELECT * FROM Clean_Sales;
```
---

# Final Output Dataset (`Clean_Sales`)

The resulting view provides a clean, deduplicated, and enriched dataset ready for Data Analysis and Business Intelligence dashboards (e.g., Power BI, Tableau).
