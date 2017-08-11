#!/usr/bin/env bash
# coding=utf-8
set -euo pipefail

mkdir -p ~/.venvs/
python3 -m venv ~/.venvs/jjb
set +u
source ~/.venvs/jjb/bin/activate
set -u
pip install --upgrade pip
pip install jenkins-job-builder
