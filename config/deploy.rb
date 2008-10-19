default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :application, "enum-and-the-protocols"
set :repository,  "git@github.com:railsrumble/enum-and-the-protocols.git"
set :user, "root"

role :app, "66.246.75.127"
role :web, "66.246.75.127"
role :db, "66.246.75.127", :primary => true

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
  end
end
