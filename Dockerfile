ARG N8N_VERSION="2.8.4"

# n8n 2.x uses a hardened Alpine image with apk removed — restore it from a stock Alpine image
FROM alpine:3.23 AS alpine

FROM n8nio/n8n:${N8N_VERSION}

USER root

# Restore apk package manager (removed in n8n 2.x hardened image)
COPY --from=alpine /sbin/apk /sbin/apk
COPY --from=alpine /usr/lib/libapk.so* /usr/lib/

# Install Python, build tools, and GraphicsMagick
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
# Enable task runners (required for n8n 2.x Code node execution)
ENV N8N_RUNNERS_ENABLED=true
# Enforce strict file permissions on n8n settings files
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
USER node

ENTRYPOINT ["/custom-entrypoint.sh"]
