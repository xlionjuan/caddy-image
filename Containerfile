# https://github.com/caddyserver/caddy/releases

FROM docker.io/library/caddy:2.11.7-builder@sha256:bf6a7d38add2508b7d2e3e3f40cf2af399214f143c0fa3daa51f254e01f8d293 AS builder

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
FROM docker.io/library/caddy:2.11.7@sha256:5e5286cb37d44086d651a5363f05f43a692ce4d649d88fb1bd844579f45fa9e8

# Copy the custom-built Caddy binary
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
