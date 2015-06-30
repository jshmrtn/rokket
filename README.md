# Rokket
[![Build Status](https://travis-ci.org/jshmrtn/rokket.svg)](https://travis-ci.org/jshmrtn/rokket)

## Roadmap
- Documentation for deployment.
- Easy integration of themes.
- Integration of theme build processes in deployment.

## Requirements

* PHP >= 5.4

## Installation

1. Clone the git repo - `git clone git@github.com:jshmrtn/rokket.git`
2. Run `composer install`
3. Copy `.env.example` to `.env` and update environment variables:
  * `DB_NAME` - Database name
  * `DB_USER` - Database user
  * `DB_PASSWORD` - Database password
  * `DB_HOST` - Database host
  * `WP_ENV` - Set to environment (`development`, `staging`, `production`)
  * `WP_HOME` - Full URL to WordPress home (http://example.com)
  * `WP_SITEURL` - Full URL to WordPress including subdirectory (http://example.com/wp)
4. Add theme(s) in `web/app/themes` as you would for a normal WordPress site.
4. Set your site vhost document root to `/path/to/site/web/` (`/path/to/site/current/web/` if using deploys)
5. Access WP admin at `http://example.com/wp/wp-admin`

## Deploys

TBA

## Contributing

Contributions are welcome from everyone. We will add [contributing guidelines](CONTRIBUTING.md) as soon as possible.

## Credits

This project started as a fork of the faboulus [roots/bedrock](https://github.com/roots/bedrock).