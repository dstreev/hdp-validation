create database if not exists ${USER} location '/user/${USER}/myhive.db';

use ${USER};

set hive.execution.engine=${EXEC_ENGINE};
set hive.execution.engine;

-- TODO: Set Queue

drop table if exists validation_partition_table;
create table validation_partition_table (
start_dtm TIMESTAMP,
end_dtm TIMESTAMP,
target_dt DATE,
nm string,
some_int string,
an_ip_addr string,
a_null string,
enrolled BOOLEAN,
consent BOOLEAN,
direction string
)
PARTITIONED BY (MY_PART STRING)
STORED AS ORC;

-- Allow Dynamic partition creation
set hive.exec.dynamic.partition.mode=nonstrict;

FROM validation_generated_src
INSERT OVERWRITE table validation_partition_table PARTITION (MY_PART)
SELECT 
    start_dtm, end_dtm,
    convert_to_date('MM/dd/yyyy', dt_to_convert),
    nm, some_int,
    an_ip_addr,
    a_null,
    bool_y,
    bool_t,
    direction,
    dt_as_is
DISTRIBUTE BY (dt_as_is, nm) SORT BY (dt_as_is, nm);

show partitions validation_partition_table;

select MY_PART, count(*) from validation_partition_table
    group by MY_PART;

select count(*) from validation_partition_table;

select count(*) from validation_partition_table where my_part='2013-02-10';
