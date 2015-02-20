# Run through hive tests.
. ./validation-env.sh

echo "Running tests with 'hive cli'"
. ./run-hive.sh hive

# Build beeline connection string
BEELINE_CONN_STR="jdbc:hive2://$HS2_HOST:$HS2_PORT"
BEELINE_CMD="beeline -u ${BEELINE_CONN_STR} -n ${USER} -p ${HS2_PASSWORD} --fastConnect=true"
echo "Running tests with 'beeline'"
. ./run-hive.sh ${BEELINE_CMD}

# Now check the compression of the ORC table compared to the original
echo "Comparing Text and ORC directory sizes"
hdfs dfs -du -h /user/${USER}/myhive.db | grep "validation_partition_table_orc|hive-validation"