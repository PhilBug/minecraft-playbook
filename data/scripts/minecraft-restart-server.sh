#!/usr/bin/env bash

echo 'msg @a WARNING!!! Server will be restarted in 60 seconds' | socat EXEC:"/usr/bin/docker attach minecraft_server",pty STDIN
sleep 60
docker restart minecraft_server
