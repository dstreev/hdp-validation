-- Dual Table definition

use default;

drop table if exists dual;

create external table dual (
id string)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/tmp/dual';
