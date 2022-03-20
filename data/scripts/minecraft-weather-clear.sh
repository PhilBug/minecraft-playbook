#!/usr/bin/env bash

echo 'weather clear 24000' | socat EXEC:"/usr/bin/docker attach minecraft_server",pty STDIN
