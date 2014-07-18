# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'JubataaS'
set :repo_url, 'git@github.com:katsyoshi/jubataas.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/jubataas'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
set :default_env, {
  rbenv_root: '/usr/local/rbenv/',
  path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH"
}
set :rbenv_type, :user
set :rbenv_custom_path, '/usr/local/rbenv'
set :rbenv_ruby, '2.1.2'

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :jubatus do
  desc 'start jubatus'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      set :ld_library_path, '/opt/jubatus/lib'
      execute "LD_LIBRARY_PATH=#{fetch(:ld_library_path)} /opt/jubatus/bin/jubaclassifier -f ${HOME}/config/jubatus/classifier_config.json -b 127.0.0.1 -p 9199 -l ${HOME}/jubatus/logs -D &"
    end
  end

  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      execute :pkill, 'jubaclassifier'
    end
  end
end
