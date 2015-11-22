#!/bin/bash
set -e

ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 3000/tcp  # churchill-node application
ufw allow 7474/tcp  # neo4j
ufw enable
