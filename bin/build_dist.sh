#!/bin/bash
 # Build the distribution packages that can be used for validation.
 
 cd `dirname $0`
 
 tar cfz ../dist/hdp-hive-validation.tgz ../hive-validation

 tar cfz ../dist/hdp-upgrade.tgz ../hdp-upgrade
