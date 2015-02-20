create database if not exists ${USER} location '/user/${USER}/myhive.db';

use ${USER};
-- Run Query on specific queue.

set hive.execution.engine=${EXEC_ENGINE};
set tez.queue.name=${QUEUE_NAME};

select start_dtm, nm, some_int from validation_partition_table where my_part='2013-02-15' and nm = '24A22';

