#!/bin/sh

SERVER_PIDFILE=/var/run/picam-streamer.pid
NODE_PATH=/usr/local/bin/node
PROG_DIR=/home/pi/picam-streamer

echo "creating directory structure..."
cd /run/shm
mkdir -p www/video
rm -f www/video/*.ts www/video/index.m3u8
for dir in rec hooks state; do
  mkdir -p $dir
  ln -sfn /run/shm/$dir $PROG_DIR/$dir
done
mkdir -p rec/tmp

# Initial state values
echo -n false > state/record

chown -R pi www rec hooks state

mkdir -p $PROG_DIR/archive
ln -sfn $PROG_DIR/archive rec/archive 2>/dev/null
chown -R pi $PROG_DIR/archive

#echo "setting microphone volume..."
#amixer set -c 0 Mic 16

echo "starting node-rtsp-rtmp-server and picam..."
cd $PROG_DIR
( nohup $NODE_PATH lib/server.js > /dev/null & echo $! >&3 ) 3>$SERVER_PIDFILE
