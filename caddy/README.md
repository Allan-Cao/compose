# Caddy Reverse Proxy

Auto-SSL Cloudflare reverse proxy using [caddy-cloudflare-proxy](https://github.com/homeall/caddy-reverse-proxy-cloudflare).

## Service Configuration
```yml
services:
  myapp:
    labels:
      caddy: example.com
      caddy.reverse_proxy: "{{upstreams 8080}}"
      caddy.tls.dns: cloudflare ${CF_API_TOKEN}
    networks:
      - caddy

networks:
  caddy:
    external: true
```

Each service's `.env` file must include `CF_API_TOKEN` with a valid Cloudflare API token.

## Cloudflare DNS

Configure DNS records in Cloudflare **before** deploying a new service.
