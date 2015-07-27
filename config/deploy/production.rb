set :stage, :production

# Pulling ENV variables for wp-cli deployments.
# ==============================================================
set :wpcli_remote_url, ENV['PRODUCTION_URL']
set :wpcli_remote_uploads_dir, ENV['PRODUCTION_UPLOADS_PATH']

# Simple Role Syntax
# ==================
#role :app, %w{deploy@example.com}
#role :web, %w{deploy@example.com}
#role :db,  %w{deploy@example.com}

# Extended Server Syntax
# ======================
server 'server.example.com', user: fetch(:deployment_user), roles: %w{web app db}

fetch(:default_env).merge!(wp_env: :production)
