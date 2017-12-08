StreamServer = require 'node-rtsp-rtmp-server'
fs = require 'fs'
url = require 'url'
path = require 'path'
child_process = require 'child_process'

PICAM_UID = 1000
PICAM_CWD = path.normalize "#{__dirname}/.."
PICAM_PATH = path.normalize "#{__dirname}/../../picam/picam"
DOCUMENT_ROOT = "/home/pi/public"

REC_DIR = path.normalize "#{__dirname}/../rec"

ACCEPT_ANY_RTSP_URLS = true
ENABLE_DEBUG_RTSP_URL = false

DO_SPAWN_PICAM = true

SERVER_NAME = "Seaturtle/0.1"

# How long a stream token is available
STREAM_TOKEN_LIFETIME = 30000  # ms

#logger.setLevel logger.LEVEL_INFO

streamServer = new StreamServer
  serverName: SERVER_NAME
  documentRoot: DOCUMENT_ROOT

picam = null

startStreamProcess = ->
  console.log "spawning picam"
  # ionice: -c1 (realtime) -n0 (highest priority)
  picam = child_process.spawn 'nice', [
    '-n', '-20', 'ionice', '-c1', '-n0', 'sudo', '-u', "##{PICAM_UID}",
    # picam command options
    PICAM_PATH, '--rtspout', '--alsadev', 'hw:1,0',
  ], {
    cwd: PICAM_CWD
    env: process.env
  }
  picam.stdout.setEncoding 'utf8'
  picam.stdout.on 'data', (data) ->
    process.stdout.write data
  picam.stderr.setEncoding 'utf8'
  picam.stderr.on 'data', (data) ->
    process.stderr.write data
  picam.on 'close', (code, signal) ->
    console.log "picam exited with code #{code}, signal #{signal}"
    process.kill process.pid, 'SIGTERM'

streamServer.start ->
  if DO_SPAWN_PICAM
    startStreamProcess()

process.on 'SIGINT', ->
  console.log "Got SIGINT. Sending SIGINT to picam"
  if DO_SPAWN_PICAM and picam?
    child_process.exec 'pidof picam', (err, stdout, stderr) ->
      if err
        console.error "pidof command error: #{err}"
        return
      picamPid = parseInt(stdout, 10)
      console.log "picam pid: #{picamPid}"
      process.kill picamPid, 'SIGINT'
  else
    process.kill process.pid, 'SIGTERM'

process.on 'uncaughtException', (err) ->
  console.error "uncaughtException"
  console.error err.stack

streamServer.setLivePathConsumer (uri, callback) ->
  pathname = url.parse(uri).pathname[1..]
  if ACCEPT_ANY_RTSP_URLS
    console.log "accept pathname: #{pathname}"
    callback null
    return
  if ENABLE_DEBUG_RTSP_URL and pathname is 'mytest'
    callback null
    return
  filename = "/run/shm/stream_token/#{pathname}"
  fs.exists filename, (exists) ->
    if exists
      fs.stat filename, (err, stats) ->
        if err
          callback err
          return
        if stats.mtime.getTime() + STREAM_TOKEN_LIFETIME < Date.now()
          console.log "Stream token is too old: #{pathname}"
          fs.unlink filename, ->
            callback new Error 'Invalid token'
        else
          fs.unlink filename, callback
    else
      callback new Error 'Invalid URI'
