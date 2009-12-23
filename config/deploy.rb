set :stages, %w(staging production)
set :default_stage, "production"
require 'capistrano/ext/multistage'

set :sync_directories, ["bin/albums", "bin/artists"]
set :sync_backups, 3