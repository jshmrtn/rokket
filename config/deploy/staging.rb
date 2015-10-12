set :stage, :staging
set :branch, :master

set :user, ENV['STAGING_USER']
set :host, ENV['STAGING_HOST']

set :deploy_to, ENV['STAGING_PATH']
set :shared_path, "#{deploy_to}/shared"

set :wpcli_local_url, ENV['DEVELOPMENT_URL']
set :wpcli_local_uploads_dir, ENV['DEVELOPMENT_UPLOADS_PATH']
set :wpcli_remote_url, ENV['STAGING_URL']
set :wpcli_remote_uploads_dir, ENV['STAGING_UPLOADS_PATH']
set :wpcli_backup_db, true

set :wpcli_phar, ENV['STAGING_WPCLI_PHAR']

SSHKit.config.command_map[:composer] = "php #{shared_path}/composer.phar"

SSHKit.config.command_map[:wp] = "$(if [ $(which wp) ]; then echo 'wp'; else echo 'php #{fetch(:wpcli_phar)}'; fi)"

server fetch(:host), user: fetch(:user), roles: %w{web app db}

fetch(:default_env).merge!(wp_env: :staging)