set :stage, :staging

# Change the :deploy_to variable for setting the deployment path
# ==============================================================
set :deploy_to, "/var/www/#{fetch(:application)}_staging"

# Pulling ENV variables for wp-cli deployments.
# ==============================================================
set :wpcli_local_url, ENV['DEVELOPMENT_URL']
set :wpcli_local_uploads_dir, ENV['DEVELOPMENT_UPLOADS_PATH']
set :wpcli_remote_url, ENV['STAGING_URL']
set :wpcli_remote_uploads_dir, ENV['STAGING_UPLOADS_PATH']

# Simple Role Syntax
# ==================
#role :app, %w{deploy@example.com}
#role :web, %w{deploy@example.com}
#role :db,  %w{deploy@example.com}

# Extended Server Syntax
# ======================
server 'server.example.com', user: fetch(:deployment_user), roles: %w{web app db}

fetch(:default_env).merge!(wp_env: :staging)
