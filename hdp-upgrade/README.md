# Post Upgrade Scripts for an Ambari Managed HDP Cluster

The HDP platform is growing significantly with each release.  Upgrading just the HDP libraries isn't always enough.  With each release, several configuration options may be added.  AND with each release, the HDP engineers may adjust some parameters to reflect the most common/efficient settings for HDP.

In the past, the only way to get all of these "new" settings was to "rebuild" the cluster with a fresh install of Ambari.

These scripts are designed to "reset" an HDP cluster, via Ambari, to a default working state.  It will validate the existence of all the required properties and selectively "reset" some properties to a known working value based on a clean HDP installation.

### WARNINGS

The scripts WILL reset values that may have been adjusted for expanded HDP components like "Ranger".  These components will most likely need to be reinstalled (need to do that anyhow with the upgrade) and reconfigured.

The scripts WILL reset values related to Hive Queries and execution to reflect the most current settings recommended by HDP Engineering.

### Preparation

Backed ALL related HDP Databases. Ambari, Hive, Oozie.

### Running the Scripts

#### Library Validation and Installation

`install-libs.sh` needs to be run as the 'hdfs' user on a validate cluster node.  It will check to ensure that all of the required libraries and files have been copied to the appropriate HDFS locations to support execution via YARN and OOZIE.

`reset-hdp.sh` interacts with Ambari, via the REST API, to validate/reset the necessary properties for the HDP cluster.  The adjustments will be "versioned" in Ambari if you need to recall previous values at a later date.

### TODO

- HBase
- Falcon
- Storm