#!/bin/sh

cd `dirname $0`

SECTION=$1

echo "Processing section: ${SECTION} at ${DT}"
if [ ! -f ${OUTPUT_DEST}/${HDP_ENV} ]; then
    mkdir -p ${OUTPUT_DEST}/${HDP_ENV}
fi

CUR_CONFIG="${OUTPUT_DEST}/${HDP_ENV}/${SECTION}.txt"

# Query Ambari for the sections settings and save to a temp file.
CMD="${AMBARI_CFG_SCRIPT} -u ${AMBARI_USER} -p ${AMBARI_PASSWORD} -port ${AMBARI_PORT} get ${AMBARI_HOST} ${AMBARI_CLUSTER_NAME} ${SECTION} > ${CUR_CONFIG}"
echo ${CMD}
eval "${CMD}"
