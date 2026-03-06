# https://github.com/caddyserver/caddy/releases

FROM docker.io/library/caddy:2.11.1-builder@sha256:4c616f045f9569b3c216c4c3d4afdc418c44d2b9b301358d9a0bc83f6e3927a8 AS builder

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
FROM docker.io/library/caddy:2.11.1@sha256:9068f76202c0a03545036d32bf2d424d3b46c1174f254070f605002a2dbc9657

# Copy the custom-built Caddy binary
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
