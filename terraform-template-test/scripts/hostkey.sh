#!/bin/sh
# Reads a VM's ssh host key. Query and result are JSON on stdin/stdout.

set -e

host=$(sed -n 's/.*"host"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')

key=$(ssh-keyscan -T 30 -t ed25519,rsa "$host" 2>/dev/null | awk '{print $3}' | sort | head -1)

printf '{"key":"%s"}' "$key"
