#!/bin/bash

# Idempotent

if [[ ! -d "venv" ]]; then
    /usr/bin/python3.9 -m venv venv # use `sudo yum install python39` on Rocky Linux 8 to install this
fi
. venv/bin/activate
pip install -U pip
if [[ -f "requirements.txt" ]]; then
    pip install -r requirements.txt
fi
if [[ -f "requirements.yml" ]]; then
    ansible-galaxy role install -fr requirements.yml -p ./roles
    ansible-galaxy collection install -fr requirements.yml -p ./collections
fi
