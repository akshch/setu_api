require 'mina/rails'
require 'mina/git'
# require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
require 'mina/rvm'    # for rvm support. (https://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :application_name, 'setu_api'
set :domain, '142.93.218.46'
set :deploy_to, '/home/deployer/apps/setu_api'
set :repository, 'git@github.com:akshch/setu_api.git'
set :branch, 'main'
set :user, "deployer"
set :forward_agent, true
set :ssh_options, "-A"

# Optional settings:
#   set :user, 'foobar'          # Username in the server to SSH to.
#   set :port, '30000'           # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
# set :shared_dirs, fetch(:shared_dirs, []).push('public/assets')
# set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')
set :shared_path, -> { "#{fetch(:deploy_to)}/shared" }
set :shared_dirs, fetch(:shared_dirs, []).push("tmp")
set :shared_files, fetch(:shared_files, []).push("config/database.yml", "config/master.key")

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
   invoke :'rvm:use', 'ruby-3.0.1@default'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.3.0 --skip-existing}
  command %{gem install bundler}
  command %[touch "#{fetch(:shared_path)}/config/database.yml"]
  command %[touch "#{fetch(:shared_path)}/config/master.key"]
  command %[touch "#{fetch(:shared_path)}/config/app_config.yml"]
  command %[mkdir "#{fetch(:shared_path)}/tmp/pids"]
  comment "Be sure to edit '#{fetch(:shared_path)}/config/database.yml', 'master.key' and app_config.yml."
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    # invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :'rewrite_cronjob'
      # in_path(fetch(:current_path)) do
      #   command %{mkdir -p tmp/}
      #   command %{touch tmp/restart.txt}
      # end
    end
  end

desc "Write crontab whenever"
task :rewrite_cronjob do
  queue %{
    echo "-----> Update crontab for #{current_path} #{release_path}"
    #{echo_cmd %[cd #{deploy_to!}/current ; bundle exec whenever --set environment=#{rails_env} -c]}
    #{echo_cmd %[cd #{deploy_to!}/current ; bundle exec whenever --set environment=#{rails_env}]}
    #{echo_cmd %[cd #{deploy_to!}/current ; bundle exec whenever --set environment=#{rails_env} -w  ]}
  }
end
  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
