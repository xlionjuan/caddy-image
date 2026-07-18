# caddy-image

Personal [Caddy](https://caddyserver.com/) builds just for adding plugins.

## How to made your own?

1. Fork this repository
2. [Install Renovate GitHub App to your forked repository](https://docs.renovatebot.com/getting-started/installing-onboarding/)
3. Modify [Containerfile](Containerfile) to suit your need, for example, you want to keep only `github.com/caddy-dns/cloudflare`
4. After few minutes, you should see `caddy-image` at the right side -> , down after `Packages` section!

## Image tag

For me, it would be

```
ghcr.io/xlionjuan/caddy-image:amd64
```

Or,

```
ghcr.io/xlionjuan/caddy-image:arm64
```

Replace your username with yours.

Choose your own architecture and put at your `compose.yml`.

## Future maintenance for this repo

Usually **don't needed** as long as you installed Renovatebot successfully, because the [renovate.json](renovate.json) is already configured to upgrade the Caddy image tag on its own, and will only pushed to main after build succeed,

You'll only need to keep an eye on the major updates, like v2 to v3, because major updates are not merged automatically.
