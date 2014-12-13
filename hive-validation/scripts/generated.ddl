create database if not exists hdp_validation;

use hdp_validation;

drop table if exists generated_src;
create external table generated_src (
start_dtm string,
end_dtm string,
dt_to_convert string,
dt_as_is string,
nm string,
some_int string,
an_ip_addr string,
a_null string,
bool_y string,
bool_t string,
direction string
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
NULL DEFINED AS 'NULL'
STORED AS TEXTFILE
LOCATION '/tmp/hive-validation';
-- Note, the added line after the last statement is important to ensure
--   beeline processes the last request.