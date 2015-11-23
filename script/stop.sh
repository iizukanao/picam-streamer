#!/bin/sh

SERVER_PIDFILE=/var/run/picam-streamer.pid

if [ -e $SERVER_PIDFILE ]; then
  echo "stopping node-rtsp-rtmp-server and picam..."
  server_pid=`cat $SERVER_PIDFILE`
  kill -INT $server_pid
  rm -f $SERVER_PIDFILE
fi
