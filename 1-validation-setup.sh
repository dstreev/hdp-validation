# Get the environment values
. ./validation-env.sh

# Create a DUAL table to use for testing functions.
# Move the dual.txt file to hdfs /tmp/dual
hdfs dfs -test -d /tmp/dual && echo "Target Directory already exists, removing"; hdfs dfs -rm -r -f -skipTrash /tmp/dual
# (re)Build Dual
hdfs dfs -mkdir /tmp/dual
hdfs dfs -put data/dual.txt /tmp/dual/

# Move the need files to HDFS.
hdfs dfs -test -d /apps/hive/shared/lib && echo "Shared Lib directory exists" || echo "Need to create the /apps/hive/shared/lib and make 'hive' the owner"; exit -1;

hdfs dfs -test -f /apps/hive/shared/lib/hive.honey-1.0-SNAPSHOT-shaded.jar && \
    echo "Jar found, replacing with current version"; hdfs dfs -rm -f  -skipTrash /apps/hive/shared/lib/hive.honey-1.0-SNAPSHOT-shaded.jar

hdfs dfs -put lib/hive.honey-1.0-SNAPSHOT-shaded.jar /apps/hive/shared/lib

hdfs dfs -test -d /tmp/hive-validation && echo "Existing Generated Data exists, removing"; hdfs dfs -rm -r -f -skipTrash /tmp/hive-validation

# Run the Data Generator Tool.
hadoop jar lib/data.gen-1.0-SNAPSHOT-shaded.jar \
com.hortonworks.pso.data.generator.mapreduce.DataGenTool \
-count $DG_RECORDS \
-mappers $DG_MAPPERS \
-output /tmp/hive-validation

