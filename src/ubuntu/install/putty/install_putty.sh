#!/usr/bin/env bash
set -ex

add-apt-repository universe
apt-get update
apt install -y putty

cp /usr/share/applications/putty.desktop $HOME/Desktop/
chmod +x $HOME/Desktop/putty.desktop