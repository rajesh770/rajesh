#!/bin/sh
# Vesion 1.0
# This Script is writtne by AIP team to monitoring performance of NameNode

TMPFILE="/home/r.thai.satyanarayana/ResultNamenode.txt"
TODAY=$(date)

{
echo "Date: $TODAY";

echo "Name Node uptime"

curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=java.lang:type=Runtime::Uptime |grep Uptime;

echo "NameNode Usage"

curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=NameNodeInfo::Used |grep Used;

echo "NameNode Free"

curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=NameNodeInfo::Free |grep Free;

echo "NumberOfMissingBlocks"

curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=NameNodeInfo::NumberOfMissingBlocks | grep NumberOfMissingBlocks;

echo "UnderReplicatedBlocks"

curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=FSNamesystem::UnderReplicatedBlocks | grep UnderReplicatedBlocks;

echo "NameNode MemNonHeapUsedM "

curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemNonHeapUsedM | grep MemNonHeapUsedM;

echo "NameNode MemNonHeapCommittedM"

curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemNonHeapCommittedM | grep MemNonHeapCommittedM;

echo "NameNode MemNonHeapMaxM"

curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemNonHeapMaxM | grep MemNonHeapMaxM; 

echo "NameNode MemHeapUsedM"

curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemHeapUsedM | grep MemHeapUsedM;

echo "NameNode MemHeapCommittedM"

curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemHeapCommittedM | grep MemHeapCommittedM;

echo "NameNode MemHeapMaxM"

curl -i --negotiate -u : http://name-node.ciodev.local:50070/jmx?get=Hadoop:service=NameNode,name=JvmMetrics::MemHeapMaxM | grep MemHeapMaxM;
} > $TMPFILE