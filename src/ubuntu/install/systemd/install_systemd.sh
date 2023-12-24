#!/usr/bin/env bash
set -ex

mkdir tmp
git clone https://github.com/gdraheim/docker-systemctl-replacement.git ./tmp
cp tmp/files/docker/systemctl3.py /usr/bin/systemctl
rm -rf tmp