lock '3.6.0'

set :application, 'kuma_sns'

set :repo_url, 'https://github.com/katanoZ/kuma_sns'

set :branch, ENV['BRANCH'] || 'master'

set :deploy_to, '/var/www/kuma_sns'

set :linked_files, %w{.env config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads}

set :keep_releases, 5

set :rbenv_ruby, '2.4.1'
set :rbenv_type, :system

set :log_level, :debug

set :delayed_job_workers, 1
set :delayed_job_roles, [:app]
set :delayed_job_pid_dir, '/tmp'

set :whenever_environment, "#{fetch(:stage)}"
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
SSHKit.config.command_map[:whenever] = "bundle exec whenever"

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
