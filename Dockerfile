ARG N8N_VERSION="1.123.20"

FROM n8nio/n8n:${N8N_VERSION}

USER root

# Install Python, build tools, and GraphicsMagick using apk (Alpine's package manager)
RUN apk add --no-cache \
    python3 \
    py3-pip \
    make \
    g++ \
    bash \
    graphicsmagick \
    ghostscript

# Copy and set permissions on your custom entrypoint
COPY ./entrypoint.sh /custom-entrypoint.sh
RUN chmod +x /custom-entrypoint.sh

ENV SHELL=/bin/sh
USER node

ENTRYPOINT ["/custom-entrypoint.sh"]
