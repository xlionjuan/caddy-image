# https://github.com/caddyserver/caddy/releases

FROM docker.io/library/caddy:2.10.0-builder@sha256:e5612b84a4a8c0d452da55d3d7d97985a5039ef3be6e399fd7264bb070f30559 AS builder

# Build Caddy with the Cloudflare DNS module
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-l4 \
    --with github.com/caddyserver/transform-encoder \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http@main \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec@main \
    --with github.com/hslatman/caddy-crowdsec-bouncer/layer4@main

# Final stage
FROM docker.io/library/caddy:2.10.0@sha256:c5876b163e84c44815e2fbba68245367dcf341a15947f80bffffa011bdc90ece

# Copy the custom-built Caddy binary
COPY --from=builder /usr/bin/caddy /usr/bin/caddy