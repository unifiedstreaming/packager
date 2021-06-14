#!/bin/sh
set -e

# validate required variables are set
if [ -z "$UspLicenseKey" ] && [ -z "$USP_LICENSE_KEY" ]
  then
    echo >&2 "Error: UspLicenseKey environment variable is required but not set."
    exit 1
elif [ -z "$UspLicenseKey" ]
  then
    export UspLicenseKey=${USP_LICENSE_KEY}
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
  set -- mp4split "$@"
fi

exec "$@"
