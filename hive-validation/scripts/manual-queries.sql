# Use this query to locate a distinct search value for testing.
# The generated data will start with any of these characters
#    ABDEF12345
# The eligible partitions with be by day in Feb of 2013.

select distinct nm from validation_partition_table where my_part='2013-02-18' and 'D' = substr(nm,1,1);

set hive.execution.engine=${EXEC_ENGINE};
set set tez.queue.name=${QUEUE_NAME};

select start_dtm, nm, some_int from validation_partition_table where my_part='2013-02-15' and nm = '24A22';
