#!/bin/bash

if [[ `groovy -v` != Groovy* ]];then
    echo "Groovy NOT found in PATH, Install Groovy and try again."
    exit -1
fi

DT=`date +%Y%m%d-%H%M`

for component in core-site hadoop-env hcat-env hdfs-site hive-env hive-site mapred-site oozie-env oozie-site tez-site webhcat-site yarn-env yarn-site; do
    ./reset-component.sh $component $DT
done