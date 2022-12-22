#!/bin/bash

if tty | grep -q '/dev/pts' ; then
 echo "SSH Terminal detected"
else
 until flutter-pi --release -d "190,190" ~/current_release/build/flutter_assets; do
    echo "Server 'myserver' crashed with exit code $?.  Respawning.." >&2
    sleep 1
 done
fi