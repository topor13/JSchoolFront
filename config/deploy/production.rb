set :application, "autoservice"
set :password, ask('Server password', nil)
server '82.196.10.5', user: 'deployer', port: 1026, password: fetch(:password), roles: %w{web app db}

set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache
set :repo_url,  "git@github.com:topor13/JSchoolFront.git"
set :deploy_to, "/home/deployer/JSchoolFront"

set :ssh_options, {
  forward_agent: true,
  port: 1026
}

set :log_level, :debug

set :linked_files, %w{.env config/master.key}

SSHKit.config.command_map[:rake]  = "bundle exec rake" #8
SSHKit.config.command_map[:rails] = "bundle exec rails"

set :keep_releases, 3
