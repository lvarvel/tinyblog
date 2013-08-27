require 'bundler/capistrano'
require 'capistrano-unicorn'

set :default_environment, {
  'PATH' => "/opt/cruby/bin/:$PATH"
}

set :application, 'Tiny Cat Blog'
set :repository,  'git@github.com:lvarvel/tinyblog.git'

set :scm, :git
set :branch, 'master'

set :deploy_via, :remote_cache
set :deploy_to, '/apps/tinyblog'

set :user, 'deployer'
set :use_sudo, false
set :scm_username, 'lvarvel'

set :rake, "/opt/cruby/bin/rake"
set :bundle_cmd, "/opt/cruby/bin/bundle"

ssh_options[:forward_agent] = true

# Break this into roles once we have more than one server
server '50.116.1.8', :app, :web, :db, :primary => true

# Because we preload the app, unicorn needs to be totally restarted
after 'deploy:restart', 'unicorn:restart'

# clean up old releases on each deploy
after "deploy:restart", "deploy:cleanup"

before "deploy:assets:precompile", "deploy:create_symlinks"
before "deploy:assets:precompile", "deploy:relocate_assets"

namespace 'deploy' do
  desc "Deploys symlinks for things like database.yml"
  task :create_symlinks, roles: :app  do
    run "ln -s #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end

  desc "Repoints the assets compilation directory to the shared one"
  task :relocate_assets, roles: :app  do
    run "mkdir #{latest_release}/public/blog"
    run "ln -s #{shared_path}/assets #{latest_release}/public/blog/assets"
  end
end


