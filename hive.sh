process_id=`/bin/ps -ef| grep "hiveserver2" | grep -v "grep"|awk '{print $2}'`
lates=/usr/java/jdk1.8.0_191-amd64
$lates/bin/jmap -heap $process_id > /home/r.thai.satyanarayana/heapsize.txt
sed -n '41,44p' /home/r.thai.satyanarayana/heapsize.txt