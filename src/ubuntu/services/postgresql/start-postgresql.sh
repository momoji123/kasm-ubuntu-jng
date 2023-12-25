#!/usr/bin/env bash
set -ex

sudo systemctl enable postgresql
sudo systemctl enable postgresql@13-main.service