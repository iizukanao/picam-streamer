#!/bin/sh

SERVER_PIDFILE=/var/run/picam-streamer.pid

is_alive=1

if [ -e $SERVER_PIDFILE ]; then
  server_pid=`cat $SERVER_PIDFILE`
  kill -s 0 $server_pid 2>/dev/null
  if [ $? -ne 0 ]; then
    is_alive=0
  fi
else
  is_alive=0
fi

if [ $is_alive -eq 1 ]; then
  exit 0
else
  exit 1
fi
