# Rokket
[![Build Status](https://travis-ci.org/jshmrtn/rokket.svg)](https://travis-ci.org/jshmrtn/rokket) (PHP)

[![Dependency Status](https://www.versioneye.com/user/projects/561b7b5ea193340f280012df/badge.svg?style=flat)](https://www.versioneye.com/user/projects/561b7b5ea193340f280012df) (Composer)

## Roadmap
* Adding functionality to uploads push/pull command.
* Migration to Otto for local development.
* Easy integration of themes.
* Integration of theme build processes in deployment.

## Requirements

* PHP >= 5.4
* Ansible >= 1.7 (for deployments)

## Installation

1. Clone the git repo - `git clone git@github.com:jshmrtn/rokket.git`
2. Run `composer install`
3. Copy `.env.example` to `.env` and update environment variables.
4. Add theme(s) in `web/app/themes` as you would for a normal WordPress site.
4. Set your site vhost document root to `/path/to/site/web/` (`/path/to/site/current/web/` if using deployments)
5. Access WP admin at `http://example.com/wp/wp-admin`

## Deployments

### Setup
1. Copy `config/deploy/vars/deployment_vars_local.yml.example` to `/config/deploy/vars/deployment_vars_local.yml`.
2. Copy `config/deploy/vars/deployment_vars.yml.example` to `/config/deploy/vars/deployment_vars.yml`.
2. Set your local variables in `config/deploy/vars/deployment_vars_local.yml`.
3. Set your project specific variables in `config/deploy/vars/deployment_vars.yml`.
4. Set your Dev/Staging/Production Server IP(s) or Hostname(s) in `config/deploy/hosts/*`.
5. For each different host copy `config/deploy/host_vars/yourhost.yml.example` and name it according to the declaration in `config/deploy/hosts/*`.
6. Set your host specific variables in `config/deploy/host_vars/*.yml`

### Usage
Run `./rokket.sh` for instructions.

## Contributing

Contributions are welcome from everyone. We will add [contributing guidelines](CONTRIBUTING.md) as soon as possible.

## Credits

This project started as a fork of the faboulus [roots/bedrock](https://github.com/roots/bedrock).