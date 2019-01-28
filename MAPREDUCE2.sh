#!/bin/sh
# Vesion 1.0
# This Script is writtne by AIP team to monitoring performance of JobHistoryServer

TMPFILE="/home/r.thai.satyanarayana/ResultMAPREDUCE2.txt"
TODAY=$(date)

{

echo "Date: $TODAY,  MAPREDUCE2,  JobHistoryServer ,`curl -i --negotiate -u : http://msql.ciodev.local:19888/jmx?get=Hadoop:service=JobHistoryServer,name=JvmMetrics::MemNonHeapUsedM |grep MemNonHeapUsedM`";

echo "Date: $TODAY,  MAPREDUCE2,  JobHistoryServer ,`curl -i --negotiate -u : http://msql.ciodev.local:19888/jmx?get=Hadoop:service=JobHistoryServer,name=JvmMetrics::MemNonHeapCommittedM |grep MemNonHeapCommittedM`";

echo "Date: $TODAY,  MAPREDUCE2,  JobHistoryServer ,`curl -i --negotiate -u : http://msql.ciodev.local:19888/jmx?get=Hadoop:service=JobHistoryServer,name=JvmMetrics::MemHeapUsedM |grep MemHeapUsedM`";

echo "Date: $TODAY,  MAPREDUCE2,  JobHistoryServer ,`curl -i --negotiate -u : http://msql.ciodev.local:19888/jmx?get=Hadoop:service=JobHistoryServer,name=JvmMetrics::MemHeapCommittedM |grep MemHeapCommittedM`";

echo "Date: $TODAY,  MAPREDUCE2,  JobHistoryServer ,`curl -i --negotiate -u : http://msql.ciodev.local:19888/jmx?get=Hadoop:service=JobHistoryServer,name=JvmMetrics::MemHeapMaxM | grep MemHeapMaxM`";

echo "Date: $TODAY,  MAPREDUCE2,  JobHistoryServer ,`curl -i --negotiate -u : http://msql.ciodev.local:19888/jmx?get=Hadoop:service=JobHistoryServer,name=JvmMetrics::MemMaxM | grep MemMaxM`";

} > $TMPFILE