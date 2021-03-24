FROM alpine:3.12
LABEL maintainer "Unified Streaming <support@unified-streaming.com>"

# Install packages
RUN wget -q -O /etc/apk/keys/alpine@unified-streaming.com.rsa.pub \
  https://stable.apk.unified-streaming.com/alpine@unified-streaming.com.rsa.pub

RUN apk --update \
        --repository https://stable.apk.unified-streaming.com/alpine/v3.12 \
        add mp4split=1.10.28-r0;

# Install AWS Cli
RUN apk --update -Uuv add groff less python3 py-pip && \
    pip install awscli;

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["--help"]
