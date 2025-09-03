# 🚀 AWS Athena ETL Project

This project demonstrates how to set up an **ETL pipeline using AWS Athena** to analyze synthetic web log data stored in Amazon S3. It is designed as a learning project for Data Engineering and Cloud concepts.

---

## 📂 Project Structure

```
├── notebooks/
│   └── data_generation.py     # Python script to generate synthetic web logs (CSV)
├── ddl/
│   └── create_table.sql         # Athena table DDL (for CSV format)
├── queries/
│   ├── daily_visitors.sql       # Query for daily unique visitors
│   ├── top_5_pages.sql            # Query for most visited pages
│   └── top_ips.sql              # Query for most frequent IPs
└── README.md
```

---

## 🛠️ Steps to Reproduce

### 1. Generate Sample Data

Run the Python script to generate **1000 rows of synthetic web logs**:

```bash
python data_generation.py
```

This will create a file `web_logs.csv`.

---

### 2. Upload Data to S3

* Create a bucket (example: `s3-web-logs-1`)
* Upload `web_logs.csv` to `s3://s3-web-logs-1/web-log-input/`

---

### 3. Create Athena Table

Open Athena query editor and run:

```sql
CREATE DATABASE IF NOT EXISTS ecommerce_logs;

CREATE EXTERNAL TABLE IF NOT EXISTS ecommerce_logs.web_logs (
  ip_address STRING,
  timestamp STRING,
  url STRING,
  status_code INT,
  user_agent STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  'separatorChar' = ',',
  'quoteChar' = '\"'
)
LOCATION 's3://s3-web-logs-1/web-log-input/'
TBLPROPERTIES ('has_encrypted_data'='false');
```

---

### 4. Run Queries

#### a) Daily Unique Visitors

```sql
SELECT
  date(parse_datetime(timestamp, 'yyyy-MM-dd HH:mm:ss')) AS visit_date,
  COUNT(DISTINCT ip_address) AS unique_visitors
FROM ecommerce_logs.web_logs
GROUP BY 1
ORDER BY 1;
```

#### b) Top 5 Pages

```sql
SELECT url, COUNT(*) AS hits
FROM ecommerce_logs.web_logs
GROUP BY url
ORDER BY hits DESC
LIMIT 5;
```

#### c) Top 10 IPs

```sql
SELECT ip_address, COUNT(*) AS requests
FROM ecommerce_logs.web_logs
GROUP BY ip_address
ORDER BY requests DESC, ip_address ASC
LIMIT 10;
```

---

## 🎯 Key Learnings

* Using **Athena + S3** for serverless query execution
* Understanding **SerDe** for CSV vs native formats (Parquet/ORC)
* Writing **SQL analytics queries** on raw log data
* Demonstrating results as part of a **data engineering interview project**

---

## 🚀 Next Steps / Enhancements

* Convert CSV logs → **Parquet** using AWS Glue for faster queries
* Visualize results in **Amazon QuickSight**
* Add more realistic log fields (HTTP methods, referrer, session IDs)

👩‍💻 Author: Reena Bhanushali
