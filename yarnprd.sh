#!/bin/sh
# Vesion 1.2
# This Script is writtne by AIP team to monitoring performance of ResourceManager

TMPFILE="/home/r.thai.satyanarayana/Resultyarn$(date -u +"%H%M%b%d%Y").csv"
TODAY=$(date -u +"%H%M%S%b%d%Y%Z")

{
echo "date,service,type of param, param name,value"

echo "$TODAY,YARN,ResourceManager,`curl -i --negotiate -u : http://hue.cioprd.local:8088/jmx?get=Hadoop:service=ResourceManager,name=JvmMetrics::MemNonHeapUsedM |grep MemNonHeapUsedM`";

echo "$TODAY,YARN,ResourceManager,`curl -i --negotiate -u : http://hue.cioprd.local:8088/jmx?get=Hadoop:service=ResourceManager,name=JvmMetrics::MemNonHeapCommittedM |grep MemNonHeapCommittedM`";

echo "$TODAY,YARN,ResourceManager,`curl -i --negotiate -u : http://hue.cioprd.local:8088/jmx?get=Hadoop:service=ResourceManager,name=JvmMetrics::MemHeapUsedM |grep MemHeapUsedM`";

echo "$TODAY,YARN,ResourceManager,`curl -i --negotiate -u : http://hue.cioprd.local:8088/jmx?get=Hadoop:service=ResourceManager,name=JvmMetrics::MemHeapCommittedM |grep MemHeapCommittedM`";

echo "$TODAY,YARN,ResourceManager,`curl -i --negotiate -u : http://hue.cioprd.local:8088/jmx?get=Hadoop:service=ResourceManager,name=JvmMetrics::MemHeapMaxM | grep MemHeapMaxM`";

echo "$TODAY,YARN,ResourceManager,`curl -i --negotiate -u : http://hue.cioprd.local:8088/jmx?get=Hadoop:service=ResourceManager,name=JvmMetrics::MemMaxM | grep MemMaxM`";

echo "$TODAY,YARN,ResourceManager,`curl -i --negotiate -u : http://hue.cioprd.local:8088/jmx?get=Hadoop:service=ResourceManager,name=QueueMetrics,q0=root,q1=default::AppsRunning | grep AppsRunning`";

echo "$TODAY,YARN,ResourceManager,`curl -i --negotiate -u : http://hue.cioprd.local:8088/jmx?get=Hadoop:service=ResourceManager,name=QueueMetrics,q0=root,q1=default::AppsPending | grep AppsPending`";

echo "$TODAY,YARN,ResourceManager,`curl -i --negotiate -u : http://hue.cioprd.local:8088/jmx?get=Hadoop:service=ResourceManager,name=QueueMetrics,q0=root,q1=default::AppsCompleted | grep AppsCompleted`";

echo "$TODAY,YARN,ResourceManager,`curl -i --negotiate -u : http://hue.cioprd.local:8088/jmx?get=Hadoop:service=ResourceManager,name=QueueMetrics,q0=root,q1=default::AppsKilled |grep AppsKilled`";

echo "$TODAY,YARN,ResourceManager,`curl -i --negotiate -u : http://hue.cioprd.local:8088/jmx?get=Hadoop:service=ResourceManager,name=QueueMetrics,q0=root,q1=default::AppsFailed | grep AppsFailed`";

echo "$TODAY,YARN,ResourceManager,`curl -i --negotiate -u : http://hue.cioprd.local:8088/jmx?get=Hadoop:service=ResourceManager,name=QueueMetrics,q0=root,q1=default::AllocatedContainers | grep AllocatedContainers`";

}|sed 's/[\""[:space:]]//g'|sed 's/:/,/g'> $TMPFILE