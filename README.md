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
docker run \
  -e USP_LICENSE_KEY=<your_license_key> \
  -v $PWD:/data \
  unifiedstreaming/packager:1.8.4 \
  -o /data/<output_filename> \
  /data/<input_filename>
```

Custom images
------------------
You can also build your own images using our Alpine repository:

```Dockerfile
FROM alpine:3.4

# Install packages
RUN wget -q -O /etc/apk/keys/alpine@unified-streaming.com.rsa.pub \
  http://apk.unified-streaming.com/alpine@unified-streaming.com.rsa.pub

RUN apk --update \
        --repository http://apk.unified-streaming.com/repo \
        add mp4split
```
