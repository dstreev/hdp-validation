# This script was built to support the Upgrade from HDP 2.1 to HDP 2.2 as indicated here:

# Please set these to match your environment
# =========================
CLUSTER_NAME=NOT_SET
ATS_FQDN=NOT_SET
# =========================

if [ "$CLUSTER_NAME" == "NOT_SET" ]; then
    echo "PLEASE SET THE CLUSTER NAME"
    exit -1
fi
if [ "$ATS_FQDN" == "NOT_SET" ]; then
    echo "PLEASE SET THE ATS FQDN"
    exit -1
fi

AMBARI_HOST=localhost
AMBARI_PORT=8080
AMBARI_USER=admin
AMBARI_PASSWORD=admin

CONFIG_SCRIPT=/var/lib/ambari-server/resources/scripts/configs.sh

# Core Site Upgrade
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME core-site "hadoop.http.authentication.simple.anonymous.allowed" "true"

# HDFS Site upgrade
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hdfs-site "dfs.namenode.startup.delay.block.deletion.sec" "3600"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hdfs-site "dfs.datanode.max.transfer.threads" "4096"

# Yarn-site Upgrade
#$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "hadoop.registry.zk.quorum" "<!--List of hostname:port pairs defining the zookeeper quorum binding for the registry-->"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.application.classpath" "$HADOOP_CONF_DIR,/usr/hdp/current/hadoop-client/*,/usr/hdp/current/hadoop-client/lib/*,/usr/hdp/current/hadoop-hdfs-client/*,/usr/hdp/current/hadoop-hdfs-client/lib/*,/usr/hdp/current/hadoop-yarn-client/*,/usr/hdp/current/hadoop-yarn-client/lib/*"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "hadoop.registry.rm.enabled" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.client.nodemanager-connect.max-wait-ms" "900000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.client.nodemanager-connect.retry-interval-ms" "10000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.node-labels.fs-store.retry-policy-spec" "2000," "500"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.node-labels.fs-store.root-dir" "/system/yarn/node-labels"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.node-labels.manager-class" "org.apache.hadoop.yarn.server.resourcemanager.nodelabels.MemoryRMNodeLabelsManager"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.nodemanager.bind-host" "0.0.0.0"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.nodemanager.disk-health-checker.max-disk-utilization-per-disk-percentage" "90"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.nodemanager.disk-health-checker.min-free-space-per-disk-mb" "1000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.nodemanager.linux-container-executor.cgroups.hierarchy" "hadoop-yarn"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.nodemanager.linux-container-executor.cgroups.mount" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.nodemanager.linux-container-executor.cgroups.strict-resource-usage" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.nodemanager.linux-container-executor.resources-handler.class" "org.apache.hadoop.yarn.server.nodemanager.util.DefaultLCEResourcesHandler"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.nodemanager.log-aggregation.debug-enabled" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.nodemanager.log-aggregation.num-log-files-per-app" "30"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.nodemanager.log-aggregation.roll-monitoring-interval-seconds" "-1"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.nodemanager.recovery.dir" "/var/log/hadoop-yarn/nodemanager/recovery-state"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.nodemanager.recovery.enabled" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.nodemanager.resource.cpu-vcores" "1"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.nodemanager.resource.percentage-physical-cpu-limit" "100"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.bind-host" "0.0.0.0"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.connect.max-wait.ms" "900000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.connect.retry-interval.ms" "30000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.fs.state-store.retry-policy-spec" "2000," "500"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.fs.state-store.uri" "" ""
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.ha.enabled" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.recovery.enabled" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.state-store.max-completed-applications" "${yarn.resourcemanager.max-completed-applications}"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.store.class" "org.apache.hadoop.yarn.server.resourcemanager.recovery.ZKRMStateStore"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.system-metrics-publisher.dispatcher.pool-size" "10"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.system-metrics-publisher.enabled" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.webapp.delegation-token-auth-filter.enabled" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.work-preserving-recovery.enabled" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.work-preserving-recovery.scheduling-wait-ms" "10000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.zk-acl" "world:anyone:rwcda"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.zk-address" "localhost:2181"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.zk-num-retries" "1000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.zk-retry-interval-ms" "1000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.zk-state-store.parent-path" "/rmstore"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.resourcemanager.zk-timeout-ms" "10000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.timeline-service.bind-host" "0.0.0.0"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.timeline-service.client.max-retries" "30"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.timeline-service.client.retry-interval-ms" "1000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.timeline-service.http-authentication.simple.anonymous.allowed" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.timeline-service.http-authentication.type" "" "simple"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.timeline-service.leveldb-timeline-store.read-cache-size" "104857600"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.timeline-service.leveldb-timeline-store.start-time-read-cache-size" "10000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.timeline-service.leveldb-timeline-store.start-time-write-cache-size" "10000"

$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.timeline-service.webapp.address" "$ATS_FQDN:8188"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.timeline-service.webapp.https.address" "$ATS_FQDN:8190"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME yarn-site "yarn.timeline-service.address" "$ATS_FQDN:10200"

# Mapred-site Upgrade
# Add/Update
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME mapred-site "mapreduce.job.emit-timeline-data" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME mapred-site "mapreduce.jobhistory.bind-hos" "0.0.0.0"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME mapred-site "mapreduce.reduce.shuffle.fetch.retry.enabled" "1"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME mapred-site "mapreduce.reduce.shuffle.fetch.retry.interval-ms" "1000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME mapred-site "mapreduce.reduce.shuffle.fetch.retry.timeout-ms" "30000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME mapred-site "mapreduce.application.framework.path" "/hdp/apps/${hdp.version}/mapreduce/mapreduce.tar.gz#mr-framework"

$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME mapred-site "mapreduce.admin.map.child.java.opts" "-server" "-XX:NewRatio=8" "-Djava.net.preferIPv4Stack=true" "-Dhdp.version=${hdp.version}"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME mapred-site "mapreduce.admin.reduce.child.java.opts" "-server" "-XX:NewRatio=8" "-Djava.net.preferIPv4Stack=true" "-Dhdp.version=${hdp.version}"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME mapred-site "yarn.app.mapreduce.am.admin-command-opts" "-Dhdp.version=${hdp.version}"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME mapred-site "yarn.app.mapreduce.am.command-opts" "-Xmx546m" "-Dhdp.version=${hdp.version}"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME mapred-site "mapreduce.application.classpath" "$PWD/mr-framework/hadoop/share/hadoop/mapreduce/*:$PWD/mr-framework/hadoop/share/hadoop/mapreduce/lib/*:$PWD/mr-framework/hadoop/share/hadoop/common/*:$PWD/mr-framework/hadoop/share/hadoop/common/lib/*:$PWD/mr-framework/hadoop/share/hadoop/yarn/*:$PWD/mr-framework/hadoop/share/hadoop/yarn/lib/*:$PWD/mr-framework/hadoop/share/hadoop/hdfs/*:$PWD/mr-framework/hadoop/share/hadoop/hdfs/lib/*:/usr/hdp/${hdp.version}/hadoop/lib/hadoop-lzo-0.6.0.${hdp.version}.jar:/etc/hadoop/conf/secure"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME mapred-site "mapreduce.admin.user.env" "LD_LIBRARY_PATH=/usr/hdp/${hdp.version}/hadoop/lib/native:/usr/hdp/${hdp.version}/hadoop/lib/native/Linux-amd64-64"

# HBase Upgrade
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hbase-site "hbase.hregion.majorcompaction.jitter" "0.50"

$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hbase-site "hbase.hregion.majorcompaction" "604800000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hbase-site "hbase.hregion.memstore.block.multiplier" "4"

$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT delete $AMBARI_HOST $CLUSTER_NAME hbase-site "hbase.hstore.flush.retries.number" "120"

$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME capacity-scheduler "yarn.scheduler.capacity.resource-calculator" "org.apache.hadoop.yarn.util.resource.DefaultResourceCalculator";
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME capacity-scheduler "yarn.scheduler.capacity.root.accessible-node-labels" "*";
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME capacity-scheduler "yarn.scheduler.capacity.root.accessible-node-labels.default.capacity" "-1";
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME capacity-scheduler "yarn.scheduler.capacity.root.accessible-node-labels.default.maximum-capacity" "-1";
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME capacity-scheduler "yarn.scheduler.capacity.root.default-node-label-expression" ""

#$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.cluster.delegation.token.store.zookeeper.connectString" "<!-- The ZooKeeper token store connect string. -->"

$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.auto.convert.sortmerge.join.to.mapjoin" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.cbo.enable" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.cli.print.header" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.cluster.delegation.token.store.class" "org.apache.hadoop.hive.thrift.ZooKeeperTokenStore"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.cluster.delegation.token.store.zookeeper.znode" "/hive/cluster/delegation"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.conf.restricted.list" "hive.security.authenticator.manager,hive.security.authorization.manager,hive.users.in.admin.role"

$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.convert.join.bucket.mapjoin.tez" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.compress.intermediate" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.compress.output" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.dynamic.partition" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.dynamic.partition.mode" "nonstrict"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.max.created.files" "100000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.max.dynamic.partitions" "5000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.max.dynamic.partitions.pernode" "2000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.orc.compression.strategy" "SPEED"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.orc.default.compress" "ZLIB"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.orc.default.stripe.size" "67108864"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.parallel" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.parallel.thread.number" "8"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.reducers.bytes.per.reducer" "67108864"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.reducers.max" "1009"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.scratchdir" "/tmp/hive"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.submit.local.task.via.child" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.exec.submitviachild" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.fetch.task.aggr" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.fetch.task.conversion" "more"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.fetch.task.conversion.threshold" "1073741824"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.map.aggr.hash.force.flush.memory.threshold" "0.9"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.map.aggr.hash.min.reduction" "0.5"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.map.aggr.hash.percentmemory" "0.5"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.mapjoin.optimized.hashtable" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.merge.mapfiles" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.merge.mapredfiles" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.merge.orcfile.stripe.level" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.merge.rcfile.block.level" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.merge.size.per.task" "256000000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.merge.smallfiles.avgsize" "16000000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.merge.tezfiles" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.metastore.authorization.storage.checks" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.metastore.client.connect.retry.delay" "5s"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.metastore.connect.retries" "24"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.metastore.failure.retries" "24"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.metastore.server.max.threads" "100000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.optimize.constant.propagation" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.optimize.metadataonly" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.optimize.null.scan" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.optimize.sort.dynamic.partition" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.orc.compute.splits.num.threads" "10"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.prewarm.enabled" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.prewarm.numcontainers" "10"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.security.metastore.authenticator.manager" "org.apache.hadoop.hive.ql.security.HadoopDefaultMetastoreAuthenticator"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.security.metastore.authorization.auth.reads" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.server2.allow.user.substitution" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.server2.logging.operation.enabled" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.server2.logging.operation.log.location" "${system:java.io.tmpdir}/${system:user.name}/operation_logs"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.server2.table.type.mapping" "CLASSIC"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.server2.thrift.http.path" "cliservice"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.server2.thrift.http.port" "10001"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.server2.thrift.max.worker.threads" "500"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.server2.thrift.sasl.qop" "auth"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.server2.transport.mode" "binary"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.server2.use.SSL" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.smbjoin.cache.rows" "10000"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.stats.dbclass" "fs"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.stats.fetch.column.stats" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.stats.fetch.partition.stats" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.support.concurrency" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.tez.auto.reducer.parallelism" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.tez.cpu.vcores" "-1"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.tez.dynamic.partition.pruning" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.tez.dynamic.partition.pruning.max.data.size" "104857600"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.tez.dynamic.partition.pruning.max.event.size" "1048576"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.tez.log.level" "INFO"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.tez.max.partition.factor" "2.0"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.tez.min.partition.factor" "0.25"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.tez.smb.number.waves" "0.5"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.user.install.directory" "/user/"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.vectorized.execution.reduce.enabled" "false"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.zookeeper.client.port" "2181"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.zookeeper.namespace" "hive_zookeeper_namespace"

#$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.zookeeper.quorum <!-- List of zookeeper server to talk to -->

$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.metastore.client.socket.timeout" "1800s"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.optimize.reducededuplication.min.reducer" "4"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.security.authorization.manager" "org.apache.hadoop.hive.ql.security.authorization.plugin.sqlstd.SQLStdConfOnlyAuthorizerFactory"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.security.metastore.authorization.manager" "org.apache.hadoop.hive.ql.security.authorization.StorageBasedAuthorizationProvider,org.apache.hadoop.hive.ql.security.authorization.MetaStoreAuthzAPIAuthorizerEmbedOnly"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.server2.support.dynamic.service.discovery" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "hive.vectorized.groupby.checkinterval" "4096"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "fs.file.impl.disable.cache" "true"
$CONFIG_SCRIPT -u $AMBARI_USER -p $AMBARI_PASSWORD -p $AMBARI_PORT set $AMBARI_HOST $CLUSTER_NAME hive-site "fs.hdfs.impl.disable.cache" "true"
