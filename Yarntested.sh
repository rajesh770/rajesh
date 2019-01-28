#!/bin/sh
# Vesion 1.0
# This Script is writtne by AIP team to monitoring performance of ResourceManager

TMPFILE="/home/r.thai.satyanarayana/ResultResourceManager.txt"
TODAY=$(date)

{

echo "Date: $TODAY";

echo "Usage of MemNonHeapUsedM"

curl -i --negotiate -u : http://ambari.ciodev.local:8088/jmx?get=Hadoop:service=ResourceManager,name=JvmMetrics::MemNonHeapUsedM |grep MemNonHeapUsedM;

echo "Usage MemNonHeapCommittedM"

curl -i --negotiate -u : http://ambari.ciodev.local:8088/jmx?get=Hadoop:service=ResourceManager,name=JvmMetrics::MemNonHeapCommittedM |grep MemNonHeapCommittedM;

echo "Usage of MemHeapUsedM"

curl -i --negotiate -u : http://ambari.ciodev.local:8088/jmx?get=Hadoop:service=ResourceManager,name=JvmMetrics::MemHeapUsedM |grep MemHeapUsedM;

echo "Usage of MemHeapCommittedM"

curl -i --negotiate -u : http://ambari.ciodev.local:8088/jmx?get=Hadoop:service=ResourceManager,name=JvmMetrics::MemHeapCommittedM |grep MemHeapCommittedM;

echo "Usage of MemHeapMaxM"

curl -i --negotiate -u : http://ambari.ciodev.local:8088/jmx?get=Hadoop:service=ResourceManager,name=JvmMetrics::MemHeapMaxM | grep MemHeapMaxM;

echo "Usage of MemMaxM"

curl -i --negotiate -u : http://ambari.ciodev.local:8088/jmx?get=Hadoop:service=ResourceManager,name=JvmMetrics::MemMaxM | grep MemMaxM;

echo "AppsRunning"
curl -i --negotiate -u : http://ambari.ciodev.local:8088/jmx?get=Hadoop:service=ResourceManager,name=QueueMetrics,q0=root,q1=default::AppsRunning | grep AppsRunning;

echo "AppsPending"
curl -i --negotiate -u : http://ambari.ciodev.local:8088/jmx?get=Hadoop:service=ResourceManager,name=QueueMetrics,q0=root,q1=default::AppsPending | grep AppsPending;

echo "AppsCompleted"
curl -i --negotiate -u : http://ambari.ciodev.local:8088/jmx?get=Hadoop:service=ResourceManager,name=QueueMetrics,q0=root,q1=default::AppsCompleted | grep AppsCompleted;

echo "AppsKilled"
curl -i --negotiate -u : http://ambari.ciodev.local:8088/jmx?get=Hadoop:service=ResourceManager,name=QueueMetrics,q0=root,q1=default::AppsKilled |grep AppsKilled;

echo "AppsFailed"
curl -i --negotiate -u : http://ambari.ciodev.local:8088/jmx?get=Hadoop:service=ResourceManager,name=QueueMetrics,q0=root,q1=default::AppsFailed | grep AppsFailed;

echo "AllocatedContainers"
curl -i --negotiate -u : http://ambari.ciodev.local:8088/jmx?get=Hadoop:service=ResourceManager,name=QueueMetrics,q0=root,q1=default::AllocatedContainers | grep AllocatedContainers;

} > $TMPFILE