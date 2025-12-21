# Caddy Configuration
This configuration builds a custom image with the cloudflare and caddy-docker-proxy plugins.

> Remember to configure DNS in Cloudflare BEFORE modifying Caddy

## Stack Configuration
```yml
SERVICE:
  labels:
    caddy: example.com
    caddy.reverse_proxy: "{{upstreams 8080}}"
    caddy.tls.dns: cloudflare {env.CF_API_TOKEN}
  networks:
    - caddy

networks:
  caddy:
    external: true
```