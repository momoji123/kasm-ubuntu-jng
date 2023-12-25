#!/usr/bin/env bash
set -ex

sudo systemctl start postgresql
sudo systemctl start postgresql@13-main.service