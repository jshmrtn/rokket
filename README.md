# Rokket
[![Build Status](https://travis-ci.org/jshmrtn/rokket.svg)](https://travis-ci.org/jshmrtn/rokket)

Composer: [![Dependency Status](https://www.versioneye.com/user/projects/561b7b5ea193340f280012df/badge.svg?style=flat)](https://www.versioneye.com/user/projects/561b7b5ea193340f280012df)

Rubygems: [![Dependency Status](https://www.versioneye.com/user/projects/561b7b5ba193340f2f0013f1/badge.svg?style=flat)](https://www.versioneye.com/user/projects/561b7b5ba193340f2f0013f1)

## Roadmap
* Documentation for deployment.
* Easy integration of themes.
* Integration of theme build processes in deployment.

## Requirements

* PHP >= 5.4
* Ruby >= 1.9 (for deployment)

## Installation

1. Clone the git repo - `git clone git@github.com:jshmrtn/rokket.git`
2. Run `composer install`
3. Copy `.env.dev.example` to `.env` and update environment variables.
4. Add theme(s) in `web/app/themes` as you would for a normal WordPress site.
4. Set your site vhost document root to `/path/to/site/web/` (`/path/to/site/current/web/` if using deploys)
5. Access WP admin at `http://example.com/wp/wp-admin`

## Deploys

TBA

## Contributing

Contributions are welcome from everyone. We will add [contributing guidelines](CONTRIBUTING.md) as soon as possible.

## Credits

This project started as a fork of the faboulus [roots/bedrock](https://github.com/roots/bedrock).