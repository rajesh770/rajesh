#!/bin/sh
# Vesion 1.1
# This Script is writtne by AIP team to monitoring performance of HDFS

TMPFILE="/home/r.thai.satyanarayana/Resulthdfs$(date -u +"%H%M%b%d%Y").csv"
TODAY=$(date -u +"%H%M%S%b%d%Y%Z")

{
echo "date,service,type of param, param name,value"

echo "$TODAY,HDFS,Name Node ,`curl -i --negotiate -u : http://name-node.cioprd.local:50070/jmx?get=java.lang:type=Runtime::Uptime |grep Uptime`";

echo "$TODAY,HDFS,Name Node ,`curl -i --negotiate -u : http://name-node.cioprd.local:50070/jmx?get=Hadoop:service=NameNode,name=NameNodeInfo::Used |grep Used`";

echo "$TODAY,HDFS,Name Node,`curl -i --negotiate -u : http://name-node.cioprd.local:50070/jmx?get=Hadoop:service=NameNode,name=NameNodeInfo::Free |grep Free`";

echo "$TODAY,HDFS ,Name Node,`curl -i --negotiate -u : http://name-node.cioprd.local:50070/jmx?get=Hadoop:service=NameNode,name=NameNodeInfo::NumberOfMissingBlocks | grep NumberOfMissingBlocks`";

echo "$TODAY,HDFS,Name Node,`curl -i --negotiate -u : http://name-node.cioprd.local:50070/jmx?get=Hadoop:service=NameNode,name=FSNamesystem::UnderReplicatedBlocks | grep UnderReplicatedBlocks`";

echo "$TODAY,HDFS,Name Node,`curl -i --negotiate -u : http://name-node.cioprd.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemNonHeapUsedM | grep MemNonHeapUsedM`";

echo "$TODAY,HDFS,Name Node,`curl -i --negotiate -u : http://name-node.cioprd.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemNonHeapCommittedM | grep MemNonHeapCommittedM`";

echo "$TODAY,HDFS ,Name Node,`curl -i --negotiate -u : http://name-node.cioprd.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemNonHeapMaxM | grep MemNonHeapMaxM`";

echo "$TODAY,HDFS,Name Node,`curl -i --negotiate -u : http://name-node.cioprd.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemHeapUsedM | grep MemHeapUsedM`";

echo "$TODAY,HDFS,Name Node,`curl -i --negotiate -u : http://name-node.cioprd.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemHeapCommittedM | grep MemHeapCommittedM`";

echo "$TODAY,HDFS,Name Node,`curl -i --negotiate -u : http://name-node.cioprd.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemHeapMaxM | grep MemHeapMaxM`";
}|sed 's/[\""[:space:]]//g'|sed 's/:/,/g'> $TMPFILE