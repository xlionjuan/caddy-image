# https://github.com/caddyserver/caddy/releases

FROM docker.io/library/caddy:2.9.1-builder AS builder

# Build Caddy with the Cloudflare DNS module
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

# Final stage
FROM docker.io/library/caddy:2.9.1

# Copy the custom-built Caddy binary
COPY --from=builder /usr/bin/caddy /usr/bin/caddy