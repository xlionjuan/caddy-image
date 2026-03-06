# https://github.com/caddyserver/caddy/releases

FROM docker.io/library/caddy:2.11.2-builder@sha256:d4f984844fc3b867ac88fd814285a38eaaf5b3ecadb9ca1b3b0397182ef60cfe AS builder

# Build Caddy with the Cloudflare DNS module
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-l4 \
    --with github.com/caddyserver/transform-encoder \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http@main \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec@main \
    --with github.com/hslatman/caddy-crowdsec-bouncer/layer4@main \
    --with github.com/fvbommel/caddy-combine-ip-ranges \
    --with github.com/digilolnet/caddy-bunny-ip \
    --with github.com/WeidiDeng/caddy-cloudflare-ip
    

# Final stage
FROM docker.io/library/caddy:2.11.2@sha256:261437d35b88cc2f8fa1ed337ebb6b6ce2bd5cd61b2a28cdf83cb201db0a853b

# Copy the custom-built Caddy binary
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
