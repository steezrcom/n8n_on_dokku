ARG N8N_VERSION="1.95.3"

FROM n8nio/n8n:${N8N_VERSION}

USER root

# Install Python and build tools needed for node-gyp
RUN apt-get update && \
    apt-get install -y python3 make g++ build-essential && \
    npm config set python $(which python3) && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh /custom-entrypoint.sh
RUN chmod +x /custom-entrypoint.sh

ENV SHELL=/bin/sh
USER node

ENTRYPOINT ["/custom-entrypoint.sh"]

