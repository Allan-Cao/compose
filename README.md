# compose

Docker compose templates for my self-hosted services.

## Structure

```

├── archive/         # Unused configs
├── caddy/           # Reverse proxy with auto-SSL
├── scripts/         # Utility scripts
└── templates/       # Service templates
```

## WordPress

[Generate security keys](https://api.wordpress.org/secret-key/1.1/salt/)

### Domain Migration

After changing a WordPress domain, update the database:

```bash
docker exec -it <project>_db mariadb -u root -p<DB_ROOT_PASSWORD> <DB_NAME>
```

Then run `scripts/wp_site_migration.sql` after setting `@old_url`, `@new_url`, and table prefix.

## License

[MIT](https://choosealicense.com/licenses/mit/)
