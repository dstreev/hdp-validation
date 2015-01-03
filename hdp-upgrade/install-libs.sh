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
echo "Checking for required files in:"
echo "    - /usr/hdp/${HDP_VERSION}"

# Ensure that the needed files exists on this host
cd /usr/hdp/$HDP_VERSION
if [ ! -f hadoop/mapreduce.tar.gz ];then
     echo "hadoop/mapreduce.tar.gz isn't available on this system"
     exit -1
fi

if [ ! -f tez/lib/tez.tar.gz ]; then
     echo "tez/lib/tez.tar.gz isn't available on this system"
     exit -1
fi

if [ ! -f hive/hive.tar.gz ]; then
     echo "hive/hive.tar.gz isn't available on this system"
     exit -1
fi

if [ ! -f pig/pig.tar.gz ]; then
     echo "pig/pig.tar.gz isn't available on this system"
     exit -1
fi

if [ ! -f sqoop/sqoop.tar.gz ]; then
     echo "sqoop/sqoop.tar.gz isn't available on this system"
     exit -1
fi

if [ ! -f hadoop-mapreduce/hadoop-streaming.jar ]; then
     echo "hadoop-mapreduce/hadoop-streaming.jar isn't available on this system"
     exit -1
fi

if [ ! -f oozie/oozie-sharelib.tar.gz ]; then
     echo "oozie/oozie-sharelib.tar.gz isn't available on this system"
     exit -1
fi

cd `dirname $0`

# MapReduce Framework
# "mapreduce.application.framework.path" : "/hdp/apps/${hdp.version}/mapreduce/mapreduce.tar.gz#mr-framework",
# /usr/hdp/$HDP_VERSION/hadoop/mapreduce.tar.gz
hdfs dfs -test -d $HDFS_HDP_BASE_DIR/mapreduce && echo "Directory ${HDFS_HDP_BASE_DIR}/mapreduce exists in HDFS" || hdfs dfs -mkdir -p $HDFS_HDP_BASE_DIR/mapreduce
hdfs dfs -test -f $HDFS_HDP_BASE_DIR/mapreduce/mapreduce.tar.gz && echo "File ${HDFS_HDP_BASE_DIR}/mapreduce/mapreduce.tar.gz exists in HDFS" || echo "Copying file ${HDFS_HDP_BASE_DIR}/mapreduce/mapreduce.tar.gz to HDFS"; hdfs dfs -put /usr/hdp/$HDP_VERSION/hadoop/mapreduce.tar.gz $HDFS_HDP_BASE_DIR/mapreduce

# Tez Framework
# "tez.lib.uris" : "/hdp/apps/${hdp.version}/tez/tez.tar.gz",
# /usr/hdp/$HDP_VERSION/tez/lib/tez.tar.gz
hdfs dfs -test -d $HDFS_HDP_BASE_DIR/tez && echo "Directory ${HDFS_HDP_BASE_DIR}/tez exists in HDFS" || hdfs dfs -mkdir -p $HDFS_HDP_BASE_DIR/tez
hdfs dfs -test -f $HDFS_HDP_BASE_DIR/tez/tez.tar.gz && echo "File ${HDFS_HDP_BASE_DIR}/tez/tez.tar.gz exists in HDFS" || echo "Copying file ${HDFS_HDP_BASE_DIR}/tez/tez.tar.gz to HDFS"; hdfs dfs -put /usr/hdp/$HDP_VERSION/tez/lib/tez.tar.gz $HDFS_HDP_BASE_DIR/tez

# Templeton Hive Archive
# "templeton.hive.archive" : "hdfs:///hdp/apps/${hdp.version}/hive/hive.tar.gz",
# /usr/hdp/$HDP_VERSION/hive/hive.tar.gz
hdfs dfs -test -d $HDFS_HDP_BASE_DIR/hive && echo "Directory ${HDFS_HDP_BASE_DIR}/hive exists in HDFS" || hdfs dfs -mkdir -p $HDFS_HDP_BASE_DIR/hive
hdfs dfs -test -f $HDFS_HDP_BASE_DIR/hive/hive.tar.gz && echo "File ${HDFS_HDP_BASE_DIR}/hive/hive.tar.gz exists in HDFS" || echo "Copying file ${HDFS_HDP_BASE_DIR}/hive/hive.tar.gz to HDFS"; hdfs dfs -put /usr/hdp/$HDP_VERSION/hive/hive.tar.gz $HDFS_HDP_BASE_DIR/hive

# Templeton Pig Archive
# "templeton.pig.archive" : "hdfs:///hdp/apps/${hdp.version}/pig/pig.tar.gz",
#/usr/hdp/$HDP_VERSION/pig/pig.tar.gz
hdfs dfs -test -d $HDFS_HDP_BASE_DIR/pig && echo "Directory ${HDFS_HDP_BASE_DIR}/pig exists in HDFS" || hdfs dfs -mkdir -p $HDFS_HDP_BASE_DIR/pig
hdfs dfs -test -f $HDFS_HDP_BASE_DIR/pig/pig.tar.gz && echo "File ${HDFS_HDP_BASE_DIR}/pig/pig.tar.gz exists in HDFS" || echo "Copying file ${HDFS_HDP_BASE_DIR}/pig/pig.tar.gz to HDFS"; hdfs dfs -put /usr/hdp/$HDP_VERSION/pig/pig.tar.gz $HDFS_HDP_BASE_DIR/pig

# Templeton Sqoop Archive
# "templeton.sqoop.archive" : "hdfs:///hdp/apps/${hdp.version}/sqoop/sqoop.tar.gz",
#/usr/hdp/$HDP_VERSION/sqoop/sqoop.tar.gz
hdfs dfs -test -d $HDFS_HDP_BASE_DIR/sqoop && echo "Directory ${HDFS_HDP_BASE_DIR}/sqoop exists in HDFS" || hdfs dfs -mkdir -p $HDFS_HDP_BASE_DIR/sqoop
hdfs dfs -test -f $HDFS_HDP_BASE_DIR/sqoop/sqoop.tar.gz && echo "File ${HDFS_HDP_BASE_DIR}/sqoop/sqoop.tar.gz exists in HDFS" || echo "Copying file ${HDFS_HDP_BASE_DIR}/sqoop/sqoop.tar.gz to HDFS"; hdfs dfs -put /usr/hdp/$HDP_VERSION/sqoop/sqoop.tar.gz $HDFS_HDP_BASE_DIR/sqoop

# Templeton Streaming Jar
# "templeton.streaming.jar" : "hdfs:///hdp/apps/${hdp.version}/mapreduce/hadoop-streaming.jar",
# /usr/hdp/$HDP_VERSION/hadoop-mapreduce/hadoop-streaming.jar
hdfs dfs -test -d $HDFS_HDP_BASE_DIR/mapreduce && echo "Directory ${HDFS_HDP_BASE_DIR}/mapreduce exists in HDFS" || hdfs dfs -mkdir -p $HDFS_HDP_BASE_DIR/mapreduce
hdfs dfs -test -f $HDFS_HDP_BASE_DIR/mapreduce/hadoop-streaming.jar && echo "File ${HDFS_HDP_BASE_DIR}/mapreduce/hadoop-streaming.jar exists in HDFS" || echo "Copying file ${HDFS_HDP_BASE_DIR}/mapreduce/hadoop-streaming.jar to HDFS"; hdfs dfs -put /usr/hdp/$HDP_VERSION/hadoop-mapreduce/hadoop-streaming.jar $HDFS_HDP_BASE_DIR/mapreduce

# Reset the Oozie Libraries.
hdfs dfs -test -d /user/oozie/share && echo "Oozie share/lib exists. Backing up and reinstalling";hdfs dfs -mv /user/oozie/share /user/oozie/share.$DT || echo "Oozie share/lib doesn't exist, rebuilding..."
if [ -f /tmp/oozie-sharelib.tar.gz ]; then
    rm -f /tmp/oozie-sharelib.tar.gz
fi
if [ -d /tmp/share ]; then
    rm -rf /tmp/share
fi

echo "Making a copy of the Oozie Sharelib tarball"
cp /usr/hdp/$HDP_VERSION/oozie/oozie-sharelib.tar.gz /tmp
cd /tmp
echo "Expanding Oozie ShareLib tarball"
tar xfz oozie-sharelib.tar.gz

echo "Installing Oozie Sharelib onto HDFS"
hdfs dfs -put /tmp/share /user/oozie/

echo "Setting Oozie Sharelib permissions on HDFS"
# Validate Permissions
hdfs dfs -chmod -R o+rx /user/oozie/share
