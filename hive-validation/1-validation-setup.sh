#!/bin/bash
# Get the environment values
. ./validation-env.sh

# Helps with Reruns after HS2 permissions may make files inaccessible.
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R +rwx /user/${USER}/myhive.db

# Create a DUAL table to use for testing functions.
# Move the dual.txt file to hdfs /tmp/dual
hdfs dfs -test -d /user/${USER}/myhive.db/dual && echo 'Target Directory already exists, removing'; hdfs dfs -rm -r -f -skipTrash /user/${USER}/myhive.db/dual

# (re)Build Dual
hdfs dfs -mkdir -p /user/${USER}/myhive.db/dual

hdfs dfs -put data/dual.txt /user/${USER}/myhive.db/dual/

# Move the need files to HDFS.
hdfs dfs -test -d /user/${USER}/lib && echo 'Lib directory exists' || hdfs dfs -mkdir lib


hdfs dfs -test -f /user/${USER}/lib/hive.honey-1.0-SNAPSHOT-shaded.jar && \
    echo 'Jar found, replacing with current version'; hdfs dfs -rm -f  -skipTrash /user/${USER}/lib/hive.honey-1.0-SNAPSHOT-shaded.jar

hdfs dfs -put lib/hive.honey-1.0-SNAPSHOT-shaded.jar lib

hdfs dfs -test -d /user/${USER}/myhive.db/validation_generated_src && echo 'Existing Generated Data exists, removing'; hdfs dfs -rm -r -f -skipTrash /user/${USER}/myhive.db/validation_generated_src

# Run the Data Generator Tool.
hadoop jar lib/data.gen-1.0-SNAPSHOT-shaded.jar \
com.hortonworks.pso.data.generator.mapreduce.DataGenTool \
-count $DG_RECORDS \
-mappers $DG_MAPPERS \
-output /user/${USER}/myhive.db/validation_generated_src

HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R +rx /user/${USER}/lib
HADOOP_USER_NAME=hdfs hdfs dfs -chmod -R +rwx /user/${USER}/myhive.db
