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

## WWW Redirect

To redirect `www.example.com` → `https://example.com`, add a second set of labels with a `caddy_1` prefix:

```yml
services:
  myapp:
    labels:
      caddy: example.com
      caddy.reverse_proxy: "{{upstreams 8080}}"
      caddy.tls.dns: cloudflare ${CF_API_TOKEN}
      caddy_1: www.example.com
      caddy_1.redir: https://example.com{uri} permanent
      caddy_1.tls.dns: cloudflare ${CF_API_TOKEN}
```

The `caddy_1` prefix creates a separate site block that issues a 301 permanent redirect. Both the bare domain and `www` subdomain must have DNS records in Cloudflare.

## Cloudflare DNS

Configure DNS records in Cloudflare **before** deploying a new service. For each domain, ensure both records exist:

- `A` record for `example.com` → server IP
- `CNAME` record for `www` → `example.com`
