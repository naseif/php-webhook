#!/bin/bash
# I assume you are running in a vultr vm as root

## install the service
cp github-autoupdate-env.service /lib/systemd/system/github-autoupdate-env.service

## daemon stuff
systemctl daemon-reload
systemctl start github-autoupdate-env.service
systemctl enable github-autoupdate-env.service
