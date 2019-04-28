#!/bin/bash
set -e

rm -f /forex_api/tmp/pids/server.pid
rake db:create
rake db:migrate
rspec -fd

exec "$@"
