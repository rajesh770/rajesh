#!/bin/sh
# Vesion 1.2
# This Script is writtne by AIP team to monitoring performance of HDFS

TMPFILE="/home/r.thai.satyanarayana/Resulthdfs.txt"
TODAY=$(date -u)
{
echo "$TODAY,HDFS,Name Node ,`curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=java.lang:type=Runtime::Uptime |grep Uptime`"|sed -e 's/Node \,    \"Uptime\" : /Node,Uptime,/';

echo "$TODAY,HDFS,Name Node ,`curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=NameNodeInfo::Used |grep Used`"|sed -e 's/Node \,    \"Used\" : /Node,Used,/';

echo "$TODAY,HDFS,Name Node,`curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=NameNodeInfo::Free |grep Free`"|sed -e 's/Node\,    \"Free\" : /Node,Free,/';

echo "$TODAY,HDFS ,Name Node,`curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=NameNodeInfo::NumberOfMissingBlocks | grep NumberOfMissingBlocks`"|sed -e 's/Node\,    \"NumberOfMissingBlocks\" : /Node,NumberOfMissingBlocks,/';

echo "$TODAY,HDFS,Name Node,`curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=FSNamesystem::UnderReplicatedBlocks | grep UnderReplicatedBlocks`"|sed -e 's/Node\,    \"UnderReplicatedBlocks\" : /Node,UnderReplicatedBlocks,/';

echo "$TODAY,HDFS,Name Node,`curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemNonHeapUsedM | grep MemNonHeapUsedM`"|sed -e 's/Node\,    \"MemNonHeapUsedM\" : /Node,MemNonHeapUsedM,/';

echo "$TODAY,HDFS,Name Node,`curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemNonHeapCommittedM | grep MemNonHeapCommittedM`"|sed -e 's/Node\,    \"MemNonHeapCommittedM\" : /Node,MemNonHeapCommittedM,/';

echo "$TODAY,HDFS ,Name Node,`curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemNonHeapMaxM | grep MemNonHeapMaxM`"|sed -e 's/Node\,    \"MemNonHeapMaxM\" : /Node,MemNonHeapMaxM,/';

echo "$TODAY,HDFS,Name Node,`curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemHeapUsedM | grep MemHeapUsedM`"|sed -e 's/Node\,    \"MemHeapUsedM\" : /Node,MemHeapUsedM,/';

echo "$TODAY,HDFS,Name Node,`curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemHeapCommittedM | grep MemHeapCommittedM`"|sed -e 's/Node\,    \"MemHeapCommittedM\" : /Node,MemHeapCommittedM,/';

echo "$TODAY,HDFS,Name Node,`curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemHeapMaxM | grep MemHeapMaxM`"|sed -e 's/Node\,    \"MemHeapMaxM\" : /Node,MemHeapMaxM,/';
} > $TMPFILE