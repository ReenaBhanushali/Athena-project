SELECT ip_address, COUNT(*) AS requests
FROM ecommerce_logs.web_logs
GROUP BY ip_address
ORDER BY requests DESC
LIMIT 10;
