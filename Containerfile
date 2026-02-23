# https://github.com/caddyserver/caddy/releases

FROM docker.io/library/caddy:2.11.1-builder@sha256:1c8dc3d45e6871a24ad3b023cf39ded7a5435159dce2ea3416773a75331ac92f AS builder

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
FROM docker.io/library/caddy:2.11.1@sha256:7f5a0f0468688c5305f1caf56302efb3d2512668b73d4d4eb2202ad53ae95b66

# Copy the custom-built Caddy binary
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
