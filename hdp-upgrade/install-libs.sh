#!/bin/bash

# Use this script to ensure all the required libraries exists/copied to HDP_VERSION

# Script should be run as HDFS superuser (hdfs)
if [ `whoami` != 'hdfs' ]; then
     echo "Script needs to run as the 'hdfs' superuser"
     exit -1
fi

HDP_VERSION=2.2.0.0-2041
HDFS_HDP_BASE_DIR=/hdp/apps/$HDP_VERSION
DT=`date +%Y%m%d-%H%M`

REQUIRED_FILES="hadoop/mapreduce.tar.gz tez/lib/tez.tar.gz hive/hive.tar.gz pig/pig.tar.gz sqoop/sqoop.tar.gz"
echo ""
echo ""
echo "Installing/Validating Libraries for HDP Version: ${HDP_VERSION}"
echo ""
echo ""
echo "Checking for required files:"
echo "    - ${HDFS_HDP_BASE_DIR}/"

# Ensure that the needed files exists on this host
cd $HDFS_HDP_BASE_DIR
if [ ! -f hadoop/mapreduce.tar.gz || ! -f tez/lib/tez.tar.gz || ! -f hive/hive.tar.gz || \
    ! -f pig/pig.tar.gz || ! -f sqoop/sqoop.tar.gz || ! -f hadoop-mapreduce/hadoop-streaming.jar || \
    ! -f oozie/oozie-sharelib.tar.gz]; then
     echo "All the required files aren't available on this system"
     exit -1
fi

cd `dirname $0`

# MapReduce Framework
# "mapreduce.application.framework.path" : "/hdp/apps/${hdp.version}/mapreduce/mapreduce.tar.gz#mr-framework",
# /usr/hdp/$HDP_VERSION/hadoop/mapreduce.tar.gz
hdfs dfs -test -d $HDFS_HDP_BASE_DIR/mapreduce && echo "Directory exists in HDFS" || hdfs dfs -mkdir -p $HDFS_HDP_BASE_DIR/mapreduce
hdfs dfs -test -f $HDFS_HDP_BASE_DIR/mapreduce/mapreduce.tar.gz && echo "File exists in HDFS" || hdfs dfs -put /usr/hdp/$HDP_VERSION/hadoop/mapreduce.tar.gz $HDFS_HDP_BASE_DIR/mapreduce 

# Tez Framework
# "tez.lib.uris" : "/hdp/apps/${hdp.version}/tez/tez.tar.gz",
# /usr/hdp/$HDP_VERSION/tez/lib/tez.tar.gz
hdfs dfs -test -d $HDFS_HDP_BASE_DIR/tez && echo "Directory exists in HDFS" || hdfs dfs -mkdir -p $HDFS_HDP_BASE_DIR/tez
hdfs dfs -test -f $HDFS_HDP_BASE_DIR/tez/tez.tar.gz && echo "File exists in HDFS" || hdfs dfs -put /usr/hdp/$HDP_VERSION/tez/lib/tez.tar.gz $HDFS_HDP_BASE_DIR/tez 

# Templeton Hive Archive
# "templeton.hive.archive" : "hdfs:///hdp/apps/${hdp.version}/hive/hive.tar.gz",
# /usr/hdp/$HDP_VERSION/hive/hive.tar.gz
hdfs dfs -test -d $HDFS_HDP_BASE_DIR/hive && echo "Directory exists in HDFS" || hdfs dfs -mkdir -p $HDFS_HDP_BASE_DIR/hive
hdfs dfs -test -f $HDFS_HDP_BASE_DIR/hive/hive.tar.gz && echo "File exists in HDFS" || hdfs dfs -put /usr/hdp/$HDP_VERSION/hive/hive.tar.gz $HDFS_HDP_BASE_DIR/hive 

# Templeton Pig Archive
# "templeton.pig.archive" : "hdfs:///hdp/apps/${hdp.version}/pig/pig.tar.gz",
#/usr/hdp/$HDP_VERSION/pig/pig.tar.gz
hdfs dfs -test -d $HDFS_HDP_BASE_DIR/pig && echo "Directory exists in HDFS" || hdfs dfs -mkdir -p $HDFS_HDP_BASE_DIR/pig
hdfs dfs -test -f $HDFS_HDP_BASE_DIR/pig/pig.tar.gz && echo "File exists in HDFS" || hdfs dfs -put /usr/hdp/$HDP_VERSION/pig/pig.tar.gz $HDFS_HDP_BASE_DIR/pig 

# Templeton Sqoop Archive
# "templeton.sqoop.archive" : "hdfs:///hdp/apps/${hdp.version}/sqoop/sqoop.tar.gz",
#/usr/hdp/$HDP_VERSION/sqoop/sqoop.tar.gz
hdfs dfs -test -d $HDFS_HDP_BASE_DIR/sqoop && echo "Directory exists in HDFS" || hdfs dfs -mkdir -p $HDFS_HDP_BASE_DIR/sqoop
hdfs dfs -test -f $HDFS_HDP_BASE_DIR/sqoop/sqoop.tar.gz && echo "File exists in HDFS" || hdfs dfs -put /usr/hdp/$HDP_VERSION/sqoop/sqoop.tar.gz $HDFS_HDP_BASE_DIR/sqoop 

# Templeton Streaming Jar
# "templeton.streaming.jar" : "hdfs:///hdp/apps/${hdp.version}/mapreduce/hadoop-streaming.jar",
# /usr/hdp/$HDP_VERSION/hadoop-mapreduce/hadoop-streaming.jar
hdfs dfs -test -d $HDFS_HDP_BASE_DIR/mapreduce && echo "Directory exists in HDFS" || hdfs dfs -mkdir -p $HDFS_HDP_BASE_DIR/mapreduce
hdfs dfs -test -f $HDFS_HDP_BASE_DIR/mapreduce/hadoop-streaming.jar && echo "File exists in HDFS" || hdfs dfs -put /usr/hdp/$HDP_VERSION/hadoop-mapreduce/hadoop-streaming.jar $HDFS_HDP_BASE_DIR/mapreduce

# Reset the Oozie Libraries.
hdfs dfs -test -d /user/oozie/share && echo "Oozie share/lib exists. Backing up and reinstalling";hdfs dfs -mv /user/oozie/share /user/oozie/share.$DT || echo "Oozie share/lib doesn't exist, rebuilding"
if [ -f /tmp/oozie-sharelib.tar.gz ]; then
    rm -f /tmp/oozie-sharelib.tar.gz
fi
if [ -d /tmp/share ]; then
    rm -rf /tmp/share
fi

cp /usr/hdp/$HDP_VERSION/oozie/oozie-sharelib.tar.gz /tmp
cd /tmp
tar xvfz oozie-sharelib.tar.gz
hdfs dfs -put /tmp/share /user/oozie/

# Validate Permissions
hdfs dfs -chmod -R o+rx /user/oozie/share
