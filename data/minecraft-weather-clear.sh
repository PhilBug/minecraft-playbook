#!/usr/bin/env bash

echo 'weather rain' | socat EXEC:"/usr/bin/docker attach minecraft_server",pty STDIN
sleep 1
echo 'weather clear 24000' | socat EXEC:"/usr/bin/docker attach minecraft_server",pty STDIN
