default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :application, "mixtapeattack"
set :repository,  "git@github.com:johnhutch/mixtape_attack.git"
set :scm_username, "johnhutch"
set :user, "mixtapers"
set :admin_login, "mixtapers"

role :app, "mixtapeattack.com"
role :web, "mixtapeattack.com"
role :db, "mixtapeattack.com", :primary => true

set :deploy_to, "/home/#{admin_login}/#{application}"
set :scm, :git
set :branch, "master"

set :use_sudo, false

namespace :deploy do
  desc "restart passenger"
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with passenger"
    task t, :roles => :app do ; end
  end
  
  desc "Link shared files"
  task :before_symlink do
    run "rm -drf #{release_path}/public/bin"
    run "ln -s #{shared_path}/bin #{release_path}/public/bin"
  end
  
  desc "Create the database yaml file"
  task :after_update_code do
    db_config = <<-EOF
    production:    
      adapter: mysql
      encoding: utf8
      username: mixtapedb
      password: b1@ck@rr0w
      database: mixtapeattack
      host: db.mixtapeattack.com
    EOF
    
    put db_config, "#{release_path}/config/database.yml"
  end

end