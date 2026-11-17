# DonSeTch on Railway: the official upstream release binary (dondai44423/donsetch v5.5.4, AGPL-3.0, features http+ocr),
# downloaded from the GitHub release and sha256-verified, unmodified. Runs the MCP server in streamable-HTTP mode on
# port 8080 with bearer auth (DONSETCH_HTTP_TOKEN, generated per deploy by the template). Cache/learned state on /data.
FROM debian:trixie-slim
LABEL org.opencontainers.image.source="https://github.com/onepush-dev/donsetch"
ARG DONSETCH_VERSION=v5.5.4
ARG DONSETCH_SHA256=32dace70030b4192252ac94d96512743c520a178181b021943c9330cbc1c1a89
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl libgcc-s1 tini \
 && curl -fsSL -o /tmp/d.tgz "https://github.com/dondai44423/donsetch/releases/download/${DONSETCH_VERSION}/donsetch-linux-x64.tar.gz" \
 && echo "${DONSETCH_SHA256}  /tmp/d.tgz" | sha256sum -c - \
 && tar -xzf /tmp/d.tgz -C /usr/local/bin donsetch libonnxruntime.so && rm /tmp/d.tgz \
 && apt-get purge -y curl && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* \
 && donsetch --version
ENV DONSETCH_TRANSPORT=http \
    DONSETCH_HTTP_HOST=0.0.0.0 \
    DONSETCH_HTTP_PORT=8080 \
    XDG_CACHE_HOME=/data/cache \
    NO_COLOR=1
EXPOSE 8080
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["donsetch", "mcp"]
