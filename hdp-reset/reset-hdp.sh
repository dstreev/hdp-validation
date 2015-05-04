#!/bin/bash

if [[ `groovy -v` != Groovy* ]];then
    echo "Groovy NOT found in PATH, Install Groovy and try again."
    exit -1
fi

DT=`date +%Y%m%d-%H%M`

SOURCE=ambari

while [ $# -gt 0 ]; do
  case "$1" in
    --xml)
      shift
      SOURCE=xml
      ;;
    --base-dir)
      shift
      XML_BASE_DIR=$1
      shift
      ;;
    --help)
      echo "Usage: $0 [--xml --base-dir] --help"
      exit -1
      ;;
    *)
      break
      ;;
  esac
done

if [ "${SOURCE}" == "xml" ]; then
    COMPONENTS="core-site hdfs-site hive-site mapred-site oozie-site tez-site webhcat-site yarn-site"
else
    COMPONENTS="core-site hadoop-env hcat-env hdfs-site hive-env hive-site mapred-site oozie-env oozie-site tez-site webhcat-site yarn-env yarn-site"
fi

for COMPONENT in ${COMPONENTS}; do
    echo "${COMPONENT}"
    ./reset-component.sh ${COMPONENT} ${DT} ${SOURCE} ${XML_BASE_DIR}
done