#!/usr/bin/env bash
set -ex

apt-get update
sudo add-apt-repository ppa:unit193/encryption -y
apt-get update
apt-get install veracrypt -y