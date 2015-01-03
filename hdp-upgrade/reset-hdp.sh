#!/bin/bash

DT=`date +%Y%m%d-%H%M`

for component in core-site hadoop-env hcat-env hcat-site hdfs-site hive-env hive-site mapred-site oozie-env oozie-site tez-site webhcat-site yarn-env yarn-site; do
    ./reset-component.sh $component $DT
done