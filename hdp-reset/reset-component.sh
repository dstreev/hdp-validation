#!/bin/sh

cd `dirname $0`

. ./hdp-env.sh

SECTION=$1

DT=$2
if [ "${DT}" == "" ]; then
    DT=$(date +%Y%m%d-%H%M)
fi

SOURCE=$3
if [ "${SOURCE}" == "" ]; then
    SOURCE=ambari
fi

XML_BASE_DIR=""
if [ "${SOURCE}" == "xml" ]; then
    XML_BASE_DIR=$4
fi

echo "Processing section: ${SECTION} at ${DT}"

CUR_AMB_CONFIG="/tmp/${DT}-${SECTION}.ambari"

# If ambari, then pull the ambari configs and merge with the templates.
# If xml, then pull current ambari, merge with xml THEN reset with templates.

# Query Ambari for the sections settings and save to a temp file.
CMD="${AMBARI_CFG_SCRIPT} -u ${AMBARI_USER} -p ${AMBARI_PASSWORD} -port ${AMBARI_PORT} get ${AMBARI_HOST} ${AMBARI_CLUSTER_NAME} ${SECTION} > ${CUR_AMB_CONFIG}"
eval "$CMD"

RESET_PROPS="/tmp/${DT}-${SECTION}.new"
CHECK_CONFIG="configs_${HDP_MAJOR_VERSION}/${SECTION}"

if [ "${SOURCE}" == "xml" ]; then
    # Convert XML into digestible format.
    ./convert-xml.groovy -bd ${XML_BASE_DIR} -
    BUILD_CMD="./build-config.groovy -af ${CUR_AMB_CONFIG} -xbd ${XML_BASE_DIR} -xc ${SECTION} -cf ${CHECK_CONFIG} -osf ${RESET_PROPS}"
else
    BUILD_CMD="./build-config.groovy -af ${CUR_AMB_CONFIG} -cf ${CHECK_CONFIG} -osf ${RESET_PROPS}"
fi

#BUILD_CMD="./build-config.groovy -af ${CUR_AMB_CONFIG} -xf ${CUR_XML_CONFIG} -cf ${CHECK_CONFIG} -osf ${RESET_PROPS}"
#BUILD_CMD="./build-config.groovy -sf ${CUR_CONFIG} -cf ${CHECK_CONFIG} -osf ${RESET_PROPS}"

echo "Build Command: ${BUILD_CMD}"
eval "${BUILD_CMD}"

SET_CMD="${AMBARI_CFG_SCRIPT} -u ${AMBARI_USER} -p ${AMBARI_PASSWORD} -port ${AMBARI_PORT} set ${AMBARI_HOST} ${AMBARI_CLUSTER_NAME} ${SECTION} ${RESET_PROPS}"

eval $SET_CMD