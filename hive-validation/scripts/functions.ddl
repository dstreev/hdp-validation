create database if not exists ${USER} location '/user/${USER}/myhive.db';

use ${USER};

DROP FUNCTION IF EXISTS CONVERT_TO_DATE;
CREATE FUNCTION convert_to_date AS 'com.streever.hadoop.hive.date.honey.ConvertToDate'
        USING JAR 'hdfs:///user/${USER}/lib/hive.honey-1.0-SNAPSHOT-shaded.jar';
DROP FUNCTION IF EXISTS CONVERT_TO_TIMESTAMP;
CREATE FUNCTION CONVERT_TO_TIMESTAMP AS 'com.streever.hadoop.hive.date.honey.ConvertToTimestamp'
        USING JAR 'hdfs:///user/${USER}/lib/hive.honey-1.0-SNAPSHOT-shaded.jar';
DROP FUNCTION IF EXISTS COMBINE_TO_TIMESTAMP;
CREATE FUNCTION COMBINE_TO_TIMESTAMP AS 'com.streever.hadoop.hive.date.honey.CombineToTimestamp'
        USING JAR 'hdfs:///user/${USER}/lib/hive.honey-1.0-SNAPSHOT-shaded.jar';
DROP FUNCTION IF EXISTS REMOVE_THOUSAND_SEPARATOR;
CREATE FUNCTION REMOVE_THOUSAND_SEPARATOR AS 'com.streever.hadoop.hive.money.honey.RemoveThousandSeparator'
        USING JAR 'hdfs:///user/${USER}/lib/hive.honey-1.0-SNAPSHOT-shaded.jar';
DROP FUNCTION IF EXISTS SEQUENCE;
CREATE FUNCTION SEQUENCE AS 'com.streever.hadoop.hive.record.honey.Sequence'
        USING JAR 'hdfs:///user/${USER}/lib/hive.honey-1.0-SNAPSHOT-shaded.jar';
DROP FUNCTION IF EXISTS CONVERT_TO_END_OF_MONTH;
CREATE FUNCTION CONVERT_TO_END_OF_MONTH AS 'com.streever.hadoop.hive.date.honey.ConvertToEndOfMonth'
        USING JAR 'hdfs:///user/${USER}/lib/hive.honey-1.0-SNAPSHOT-shaded.jar';
DROP FUNCTION IF EXISTS SEED_FROM_LIST;
CREATE FUNCTION SEED_FROM_LIST AS 'com.streever.hadoop.hive.generate.honey.SeedFromList'
        USING JAR 'hdfs:///user/${USER}/lib/hive.honey-1.0-SNAPSHOT-shaded.jar';
DROP FUNCTION IF EXISTS IP_TO_LONG;
CREATE FUNCTION IP_TO_LONG AS 'com.streever.hadoop.hive.ip.honey.IpToLong'
        USING JAR 'hdfs:///user/${USER}/lib/hive.honey-1.0-SNAPSHOT-shaded.jar';
DROP FUNCTION IF EXISTS LONG_TO_IP;
CREATE FUNCTION LONG_TO_IP AS 'com.streever.hadoop.hive.ip.honey.LongToIp'
        USING JAR 'hdfs:///user/${USER}/lib/hive.honey-1.0-SNAPSHOT-shaded.jar';

show functions "${USER}.*";
