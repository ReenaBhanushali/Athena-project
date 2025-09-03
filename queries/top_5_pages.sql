SELECT url, COUNT(*) AS hits
FROM ecommerce_logs.web_logs
GROUP BY url
ORDER BY hits DESC
LIMIT 5;
