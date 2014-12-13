# Used to cycle through scripts with either hive cli or beeline
HIVE_CMD=$@
echo "Hive Command: ${HIVE_CMD}"

# Build out the functions.
# Define some global functions
$HIVE_CMD -f scripts/functions.ddl

$HIVE_CMD -f scripts/dual.ddl

# Test Global Function availability
$HIVE_CMD -f scripts/dual.sql

# Spec Generated Table
$HIVE_CMD -f scripts/generated.ddl

# Build Partitioned Table
for eng in mr tez; do
    $HIVE_CMD -f scripts/build-ptn-tbl.sql --hivevar EXEC_ENGINE=$eng 
done

# Query the partitioned table