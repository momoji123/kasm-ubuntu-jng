#!/usr/bin/env bash
set -ex

apt-get update
apt-get install -y wget gdebi-core

wget https://github.com/shiftkey/desktop/releases/download/release-3.1.1-linux1/GitHubDesktop-linux-3.1.1-linux1.deb
gdebi GitHubDesktop-linux-3.1.1-linux1.deb