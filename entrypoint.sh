#!/bin/bash
set -e

rm -f /forex_api/tmp/pids/server.pid

exec "$@"
