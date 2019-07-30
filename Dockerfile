FROM alpine:3.8
LABEL maintainer "Unified Streaming <support@unified-streaming.com>"

# Install packages
RUN wget -q -O /etc/apk/keys/alpine@unified-streaming.com.rsa.pub \
  https://stable.apk.unified-streaming.com/alpine@unified-streaming.com.rsa.pub

RUN apk --update \
        --repository https://stable.apk.unified-streaming.com/target/repo \
        add mp4split=1.10.12-r0

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["--help"]
