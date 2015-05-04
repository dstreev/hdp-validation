#!/bin/bash

export HDP_ENV=$1

if [ -f ${HDP_ENV}-env.sh ]; then
    SCRIPT="${HDP_ENV}-env.sh"
    . ./$SCRIPT
else
    . ./hdp-env.sh
    export HDP_ENV=default
fi

for component in core-site hadoop-env hcat-env hdfs-site hive-env hive-site mapred-site oozie-env oozie-site tez-site webhcat-site yarn-env yarn-site; do
    ./get-component-cfg.sh $component
done