set :application, "my_app_name"
set :repo_url, "git@example.com:me/my_repo.git"

# Branch options
# Prompts for the branch name (defaults to current branch)
# ==============================================================
# ask :branch, -> { `git rev-parse --abbrev-ref HEAD`.chomp }

# Hardcodes branch to always be master
# This could be overridden in a stage config file
# ==============================================================
set :branch, :master

# Set basic deploy_to and shared_path variables.
# ==============================================================
set :deploy_to, -> { "/var/www/#{fetch :application}_#{fetch :stage}" }
set :shared_path, "#{fetch(:deploy_to)}/shared"

# Use :debug for more verbose output when troubleshooting
# ==============================================================
set :log_level, :info

# Set time format for deploy tagging.
# ==============================================================
set :deploytag_time_format, "%Y.%m.%d-%H%M%S-cet"

# Apache users with .htaccess files:
# it needs to be added to linked_files so it persists across deploys:
# ==============================================================
# set :linked_files, fetch(:linked_files, []).push('.env', 'web/.htaccess')
set :linked_files, fetch(:linked_files, []).push(".env")
set :linked_dirs, fetch(:linked_dirs, []).push("web/app/uploads")

# Set Composer executable path
# ==============================================================
SSHKit.config.command_map[:composer] = "php #{fetch(:shared_path)}/composer.phar"

# For deployment permissions of uploads, set desired uploads user and group.
# ==============================================================
set :deployment_user, "www-root"
set :uploads_folder_user, "www-root"
set :uploads_folder_group, "www-data"

# Pulling ENV variables for wp-cli deployments.
# ==============================================================
set :wpcli_local_url, ENV["DEVELOPMENT_URL"]
set :wpcli_local_uploads_dir, ENV["DEVELOPMENT_UPLOADS_PATH"]

# For deployment of uploads, set options for building assets.
# ==============================================================
set :theme_path, Pathname.new('web/app/themes/theme_name')
set :local_app_path, Pathname.new(ENV["DEVELOPMENT_PATH"])
set :local_theme_path, fetch(:local_app_path).join(fetch(:theme_path))

namespace :wordpress do

  desc "Remove default current directory."
  task :symlink do
      on roles(:app), in: :sequence, wait: 5 do
          within deploy_to  do
              execute :sudo, :rm, "-R #{fetch(:deploy_to)}/current"
          end
      end
  end

  desc "Setup folder permissions for uploads folder."
  task :permissions do
      on roles(:app), in: :sequence, wait: 5 do
          within shared_path  do
              execute :sudo, :chmod, "-R 775 #{fetch(:shared_path)}/web/app/uploads"
              execute :sudo, :chown, "-R #{fetch(:uploads_folder_user)}:#{fetch(:uploads_folder_group)} #{fetch(:shared_path)}/web/app/uploads"
          end
      end
  end
end

namespace :assets do

  task :compile do
    run_locally do
      within fetch(:local_theme_path) do
        execute :gulp, '--production'
      end
    end
  end

  task :copy do
    on roles(:web) do
      upload! "#{fetch(:local_theme_path).join('dist')}/", release_path.join(fetch(:theme_path)), recursive: true
    end
  end
  
  task deploy: %w(compile copy)

end

namespace :deploy do
  
  before :starting,   'composer:install_executable'
  #before :publishing, 'wordpress:symlink'
  #after :published,   'wordpress:permissions'
  #before :updated,    'assets:deploy'

end

namespace :wpcli do
  namespace :uploads do
    namespace :rsync do
      #after :push, 'wordpress:permissions'
      #after :pull, 'wordpress:permissions'
    end
  end
end
