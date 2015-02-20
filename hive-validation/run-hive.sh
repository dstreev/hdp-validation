# Used to cycle through scripts with either hive cli or beeline
HIVE_CMD=$@
echo "Hive Command: ${HIVE_CMD}"

# Helps with permissions when HS2 doas is false and a Ranger policy
#  hasn't been created to allow 'hive' access to your directory.
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R +rwx /user/${USER}/myhive.db

# Build out the functions.
# Define some global functions
$HIVE_CMD -f scripts/functions.ddl --hivevar USER=${USER}

$HIVE_CMD -f scripts/dual.ddl --hivevar USER=${USER}

# Test Global Function availability
$HIVE_CMD -f scripts/dual.sql --hivevar USER=${USER}

# Spec Generated Table
$HIVE_CMD -f scripts/generated.ddl --hivevar USER=${USER}

HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R +rwx /user/${USER}/myhive.db

# Build Partitioned Table
for eng in mr tez; do
    $HIVE_CMD -f scripts/build-ptn-tbl.sql --hivevar EXEC_ENGINE=$eng --hivevar USER=${USER}
    HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R +rwx /user/${USER}/myhive.db
done

# Query the partitioned table