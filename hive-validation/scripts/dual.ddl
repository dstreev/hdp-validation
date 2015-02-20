-- Dual Table definition

create database if not exists ${USER} location '/user/${USER}/myhive.db';

use ${USER};

drop table if exists dual;

create external table dual (
id string)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;