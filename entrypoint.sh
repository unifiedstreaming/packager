#!/bin/sh
set -e

# validate required variables are set
if [ ! $USP_LICENSE_KEY ]
  then
  echo >&2 "Error: USP_LICENSE_KEY environment variable is required but not set."
  exit 1
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
  set -- mp4split --license-key=$USP_LICENSE_KEY "$@"
fi

exec "$@"
