CREATE EXTERNAL TABLE IF NOT EXISTS `ecommerce_logs`.`web_logs` (
  `ip_address` string,
  `timestamp` timestamp,
  `url` string,
  `status_code` bigint,
  `user_agent` string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ('separatorChar' = ',', 'quoteChar' = '\"')
STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat' OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 's3://s3-web-logs-1/web-log-input/'
TBLPROPERTIES (
  'classification' = 'csv',
  'skip.header.line.count' = '1',
  'has_encrypted_data' = 'false'
);
