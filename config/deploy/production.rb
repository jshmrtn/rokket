set :stage, :production
set :branch, :master

set :user, ENV['PRODUCTION_USER']
set :host, ENV['PRODUCTION_HOST']

set :deploy_to, ENV['PRODUCTION_PATH']
set :shared_path, "#{deploy_to}/shared"

set :wpcli_local_url, ENV['DEVELOPMENT_URL']
set :wpcli_local_uploads_dir, ENV['DEVELOPMENT_UPLOADS_PATH']
set :wpcli_remote_url, ENV['PRODUCTION_URL']
set :wpcli_remote_uploads_dir, ENV['PRODUCTION_UPLOADS_PATH']

set :wpcli_phar, ENV['PRODUCTION_WPCLI_PHAR']

server fetch(:host), user: fetch(:user), roles: %w{web app db}

fetch(:default_env).merge!(wp_env: :production)