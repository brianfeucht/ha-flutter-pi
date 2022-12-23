#!/bin/bash

release_id=$(curl -s "https://api.github.com/repos/brianfeucht/ha-flutter-pi/releases/latest" | jq '.assets[] | select(.name == "remote_flutter_app.tar.gz") | .id')

echo "Latest release is $release_id";

if [ ! -d /home/pi/releases/$release_id ]; then
  echo "Downloading latest release";
  mkdir -p /home/pi/releases/$release_id;

  wget -O /tmp/$release_id-remote_flutter_app.tar.gz https://github.com/brianfeucht/ha-flutter-pi/releases/download/latest/remote_flutter_app.tar.gz
  tar -xvf /tmp/$release_id-remote_flutter_app.tar.gz -C /home/pi/releases/$release_id
  rm /tmp/$release_id-remote_flutter_app.tar.gz

  ls -dt /home/pi/releases/*/ | tail -n +11 | xargs rm -rf
fi

current_release=$(readlink -f /home/pi/current_release)

if [ ! $current_release -ef "/home/pi/releases/${release_id}" ]; then
  echo "Updating current_release symlink and restarting app";
  ln -sfn /home/pi/releases/$release_id /home/pi/current_release
  pkill flutter-pi
fi
