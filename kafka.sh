#!/bin/bash
DAEMON_PATH=/opt/confluent-kafka/confluent/bin
DAEMON_NAME=kafka
PATH=$PATH:$DAEMON_PATH

case "$1" in
  start)
        # Start daemon.
        echo "Starting $DAEMON_NAME";
        nohup $DAEMON_PATH/kafka-server-start -daemon /opt/confluent-kafka/confluent/etc/kafka/server.properties
        ;;
  stop)
        # Stop daemons.
        echo "Stopping $DAEMON_NAME";
        nohup $DAEMON_PATH/kafka-server-stop -daemon /opt/confluent-kafka/confluent/etc/kafka/server.properties
        ;;
  status)
        pid=`ps ax | grep -i 'kafka' | grep -v grep | awk '{print $1}'`
        if [ -n "$pid" ]
          then
          echo "Kafka is Running as PID: $pid"
        else
          echo "Kafka is not Running"
        fi
        ;;
  *)
        echo "Usage: $0 {start|stop|status}"
        exit 1
esac

exit 0
