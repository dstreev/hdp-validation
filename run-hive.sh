# Used to cycle through scripts with either hive cli or beeline
HIVE_CMD=$@
echo "Hive Command: ${HIVE_CMD}"

# Build out the functions.
# Define some global functions
$HIVE_CMD -f hive/functions.ddl

$HIVE_CMD -f hive/dual.ddl

# Test Global Function availability
$HIVE_CMD -f hive/dual.sql

# Spec Generated Table
$HIVE_CMD -f hive/generated.ddl

# Build Partitioned Table
for eng in mr tez; do
    $HIVE_CMD -f hive/build-ptn-tbl.sql --hivevar EXEC_ENGINE=$eng 
done

# Query the partitioned table