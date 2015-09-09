#!/bin/bash

cd `dirname $0`

export HDP_ENV=$1

if [ -f env/${HDP_ENV}-env.sh ]; then
    SCRIPT="${HDP_ENV}-env.sh"
    . env/$SCRIPT
else
    . env/hdp-env.sh
    export HDP_ENV=default
fi

DT=`date +%Y%m%d_%H%M%S`

COMPONENT_LIST="Component_List_2.1.txt"

for component in `cat ${COMPONENT_LIST}`; do
#    echo "${component}"
    ./get-component-cfg.sh $component $DT
done