# https://github.com/caddyserver/caddy/releases

FROM docker.io/library/caddy:2.10.2-builder@sha256:22ff419120e17d257b9744216ecae0b2305d81ff570490fba03625f047c4195a AS builder

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
FROM docker.io/library/caddy:2.10.2@sha256:4163a5c7b7631707956db4057720ec75de429992d5e3aa518d54872c01644dbe

# Copy the custom-built Caddy binary
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
