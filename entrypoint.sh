#!/bin/sh
set -e

echo "$AWS_KEY:$AWS_SECRET_KEY" > passwd && chmod 600 passwd
s3fs "$S3_BUCKET" "$MNT_POINT" -o passwd_file=passwd -o nonempty -o uid=1001,gid=1001,allow_other,mp_umask=002

# validate required variables are set
if [ -z "$USP_LICENSE_KEY" ]
  then
  echo >&2 "Error: USP_LICENSE_KEY environment variable is required but not set."
  exit 1
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
  set -- mp4split --license-key=$USP_LICENSE_KEY "$@"
fi

exec "$@"
