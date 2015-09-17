#!/bin/sh

cd `dirname $0`

SECTION=$1
DT=$2

if [ ${DT} == "" ]; then
    DT=`date +%Y%m%d_%H%M%S`
fi

echo "Processing section: ${SECTION} at ${DT}"

OUTPUT_DIR=${HDP_ENV}_${DT}

mkdir -p ${OUTPUT_DEST}/${OUTPUT_DIR}

CUR_CONFIG="${OUTPUT_DEST}/${OUTPUT_DIR}/${SECTION}.txt"

# Query Ambari for the sections settings and save to a temp file.
CMD="${AMBARI_CFG_SCRIPT} -u ${AMBARI_USER} -p ${AMBARI_PASSWORD} -port ${AMBARI_PORT} get ${AMBARI_HOST} ${AMBARI_CLUSTER_NAME} ${SECTION} | sed -e 's/^PASSWORD.*$//g' > ${CUR_CONFIG} "
echo ${CMD}
eval "${CMD}"
