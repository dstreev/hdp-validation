#!/bin/sh

cd `dirname $0`

. ./hdp-env.sh

SECTION=$1

DT=$2
if [ "${DT}" == "" ]; then
    DT=$(date +%Y%m%d-%H%M)
fi

echo "Processing section: ${SECTION} at ${DT}"

CUR_CONFIG="/tmp/${DT}-${SECTION}.orig"

# Query Ambari for the sections settings and save to a temp file.
CMD="${AMBARI_CFG_SCRIPT} -u ${AMBARI_USER} -p ${AMBARI_PASSWORD} -port ${AMBARI_PORT} get ${AMBARI_HOST} ${AMBARI_CLUSTER_NAME} ${SECTION} > ${CUR_CONFIG}"

eval "$CMD"

RESET_PROPS="/tmp/${DT}-${SECTION}.new"
CHECK_CONFIG="configs_${HDP_MAJOR_VERSION}/${SECTION}"

BUILD_CMD="./build-config.groovy -sf ${CUR_CONFIG} -cf ${CHECK_CONFIG} -osf ${RESET_PROPS}"
#BUILD_CMD="./build-config.groovy -sf ${CUR_CONFIG} -cf ${CHECK_CONFIG} -osf ${RESET_PROPS}"
echo "Build Command: ${BUILD_CMD}"
eval "${BUILD_CMD}"

SET_CMD="${AMBARI_CFG_SCRIPT} -u ${AMBARI_USER} -p ${AMBARI_PASSWORD} -port ${AMBARI_PORT} set ${AMBARI_HOST} ${AMBARI_CLUSTER_NAME} ${SECTION} ${RESET_PROPS}"

eval $SET_CMD