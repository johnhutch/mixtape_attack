default_run_options[:pty] = true
set :application, "mixtapeattack"
set :repository,  "git@github.com:johnhutch/mixtape_attack.git"

role :app, "li24-86.members.linode.com"
role :web, "li24-86.members.linode.com"
role :db, "li24-86.members.linode.com", :primary => true

set :deploy_to, "/var/www/apps/#{application}"
set :scm, :git
set :branch, "master"

namespace :deploy do
  desc "restart passenger"
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with passenger"
    task t, :roles => :app do ; end
  end
  
  task :after_symlink do
    %w[database.yml].each do |c|
      run "ln -nsf #{shared_path}/system/config/#{c} #{current_path}/config/#{c}"
    end
    run "ln -nsf #{shared_path}/uploads/bin #{current_path}/public/bin"
  end

end