#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Starts a Zookeeper server
#
# chkconfig: 35 85 15
# description: Zookeeper
#
### BEGIN INIT INFO
# Provides:          zookeeper
# Short-Description: ZooKeeper Service
# Default-Start:     3 5
# Default-Stop:      0 1 6
# Required-Start:    $local_fs $network $remote_fs
# Required-Stop:     $local_fs $network $remote_fs
# Should-Start:
# Should-Stop:
### END INIT INFO:
DAEMON_PATH=/opt/confluent-kafka/confluent/bin
DAEMON_NAME=zookeeper
PATH=$PATH:$DAEMON_PATH

case "$1" in
  start)
        # Start daemon.
        echo "Starting $DAEMON_NAME";
        nohup $DAEMON_PATH/zookeeper-server-start -daemon /opt/confluent-kafka/confluent/etc/kafka/zookeeper.properties
        ;;
  stop)
        # Stop daemons.
        echo "Stopping $DAEMON_NAME";
        nohup $DAEMON_PATH/zookeeper-server-stop -daemon /opt/confluent-kafka/confluent/etc/kafka/zookeeper.properties
        ;;
  status)
        pid=`ps ax | grep -i 'zookeeper' | grep -v grep | awk '{print $1}'`
        if [ -n "$pid" ]
          then
          echo "zookeeper is Running as PID: $pid"
        else
          echo "zookeeper is not Running"
        fi
        ;;
  *)
        echo "Usage: $0 {start|stop|status}"
        exit 1
esac

exit 0
