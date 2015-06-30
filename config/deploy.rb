set :application, 'my_app_name'
set :repo_url, 'git@example.com:me/my_repo.git'

# Branch options
# Prompts for the branch name (defaults to current branch)
# ask :branch, -> { `git rev-parse --abbrev-ref HEAD`.chomp }

# Hardcodes branch to always be master
# This could be overridden in a stage config file
set :branch, :master

set :deploy_to, -> { "/srv/www/#{fetch(:application)}" }
set :shared_path, "#{deploy_to}/shared"

# Use :debug for more verbose output when troubleshooting
set :log_level, :info

# Set time format for deploy tagging.
set :deploytag_time_format, "%Y.%m.%d-%H%M%S-cet"

# Apache users with .htaccess files:
# it needs to be added to linked_files so it persists across deploys:
# set :linked_files, fetch(:linked_files, []).push('.env', 'web/.htaccess')
set :linked_files, fetch(:linked_files, []).push('.env')
set :linked_dirs, fetch(:linked_dirs, []).push('web/app/uploads')

# Set Composer executable path
SSHKit.config.command_map[:composer] = "php #{shared_path}/composer.phar"

# For deployment permissions of uploads, set desired uploads user and group.
set :deployment_user, 'www-root'
set :uploads_folder_user, 'www-root'
set :uploads_folder_group, 'www-data'

namespace :wordpress do
 
  desc 'Setup folder permissions for uploads folder.'
  task :permissions do
      on roles(:app), in: :sequence, wait: 5 do
          within shared_path  do
              execute :sudo, :chmod, '-R 775 web/app/uploads'
              execute :sudo, :chown, '-R #{fetch(:uploads_folder_user)}:#{fetch(:uploads_folder_group)} web/app/uploads'
          end
      end
  end
end

namespace :deploy do
  
  before :starting, 'composer:install_executable'
  after :published, 'wordpress:permissions'

end

namespace :wpcli do
  namespace :uploads do
    namespace :rsync do
      after :push, 'wordpress:permissions'
      after :pull, 'wordpress:permissions'
    end
  end
end
