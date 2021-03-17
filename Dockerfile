FROM alpine:3.12
LABEL maintainer "Unified Streaming <support@unified-streaming.com>"

# Install packages
RUN wget -q -O /etc/apk/keys/alpine@unified-streaming.com.rsa.pub \
  https://stable.apk.unified-streaming.com/alpine@unified-streaming.com.rsa.pub

RUN apk --update \
        --repository https://stable.apk.unified-streaming.com/alpine/v3.12 \
        add mp4split=1.10.28-r0;

ENV AWS_KEY=
ENV AWS_SECRET_KEY=
ENV MNT_POINT=/mnt/s3

ARG S3FS_VERSION=v1.88

RUN apk --update --no-cache add fuse alpine-sdk automake autoconf libxml2-dev fuse-dev curl-dev git bash; \
    git clone https://github.com/s3fs-fuse/s3fs-fuse.git; \
    cd s3fs-fuse; \
    git checkout tags/${S3FS_VERSION}; \
    ./autogen.sh; \
    ./configure --prefix=/usr; \
    make; \
    make install; \
    make clean; \
    rm -rf /var/cache/apk/*; \
    apk del git automake autoconf;

RUN mkdir -p "$MNT_POINT"
RUN mkdir -p /mnt/test

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["--help"]
