![logo](https://raw.githubusercontent.com/unifiedstreaming/origin/master/unifiedstreaming-logo-black.png)

Unified Packager
------------------------------
Unified Packager is a software program that uses MP4 files to produce segmented output in HDS, HLS, MPEG-DASH and HSS formats. 

DRM can also be applied using the command-line options. It smoothly handles advanced features for adding multiple audio codecs, such as Dolby Digital Plus (E-AC-3), DTS Express and Fraunhofer HE-AAC v2 (multichannel).

Documentation:
http://docs.unified-streaming.com/documentation/package/index.html

Note that latest correlates to the latest GA version (see the release notes at http://docs.unified-streaming.com/release-notes/index.html).

Docker usage instructions:

Run a container and pass the usual commands to mp4split.

```bash
export UspLicenseKey=<your_license_key> 

docker run \
  -e UspLicenseKey \
  -v $PWD:/data \
  unifiedstreaming/packager:1.11.1 \
  -o /data/<output_filename> \
  /data/<input_filename>
```

Custom images
------------------
You can also build your own images using our Alpine repository:

```Dockerfile
ARG ALPINEVERSION=3.13

FROM alpine:$ALPINEVERSION

# Get USP public key
RUN wget -q -O /etc/apk/keys/alpine@unified-streaming.com.rsa.pub \
    https://stable.apk.unified-streaming.com/alpine@unified-streaming.com.rsa.pub
    
# ARGs declared before FROM are in a different scope, so need to be stated again
# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG ALPINEVERSION
ARG BETA_REPO=https://beta.apk.unified-streaming.com/alpine/
ARG STABLE_REPO=https://stable.apk.unified-streaming.com/alpine/
ARG VERSION=1.11.1

# Install Software
RUN apk \
    --update \
    --repository $BETA_REPO/v$ALPINEVERSION \
    --repository $STABLE_REPO/v$ALPINEVERSION \
    add \
        mp4split~$VERSION \
&&  rm -f /var/cache/apk/*
```
