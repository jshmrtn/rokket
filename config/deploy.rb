set :application, ENV['APP_NAME']
set :repo_url, ENV['APP_REPO']

# Branch options
# Prompts for the branch name (defaults to current branch)
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploytag_time_format, "%Y.%m.%d-%H%M%S-cet"

# Use :debug for more verbose output when troubleshooting
set :log_level, :info

# Apache users with .htaccess files:
# it needs to be added to linked_files so it persists across deploys:
set :linked_files, fetch(:linked_files, []).push('.env')
set :linked_dirs, fetch(:linked_dirs, []).push('web/app/uploads')

# Set theme variables
set :theme_path, Pathname.new('web/app/themes/').join(ENV['THEME_NAME'])
set :local_app_path, Pathname.new(File.dirname(__FILE__)).join('../')
set :local_theme_path, fetch(:local_app_path).join(fetch(:theme_path))

namespace :assets do
  task :compile do
    run_locally do
      within fetch(:local_theme_path) do
        execute :gulp, '--production'
      end
    end
  end
 
  task :copy do
    invoke 'assets:compile'
    on roles(:web) do
      upload! fetch(:local_theme_path).join('dist').to_s, release_path.join(fetch(:theme_path)), recursive: true
    end
  end
  
  task deploy: %w(compile copy)
end

namespace :deploy do
  
  before :starting, 'composer:install_executable'
  before :updated,  'assets:deploy'

end
