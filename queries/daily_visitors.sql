SELECT 
date(parse_datetime(timestamp, 'yyyy-MM-dd HH:mm:ss')) AS visit_date,
COUNT(DISTINCT ip_address) AS unique_visitors
FROM ecommerce_logs.web_logs
GROUP BY 1
ORDER BY 1;
