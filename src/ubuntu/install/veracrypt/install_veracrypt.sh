#!/usr/bin/env bash
set -ex

apt-get update
sudo add-apt-repository ppa:unit193/encryption -y
apt-get update
apt-get install veracrypt -y
cp /usr/share/applications/veracrypt.desktop $HOME/Desktop/
chmod +x $HOME/Desktop/veracrypt.desktop