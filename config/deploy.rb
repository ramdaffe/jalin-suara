set :application, "Jalin Suara"
set :repository,  "git@bitbucket.org:qbl/mapstories.git"
set :scm, :git
ssh_options[:forward_agent] = true

server "ec2-50-19-205-190.compute-1.amazonaws.com", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/jalinsuara"

set :use_sudo, false

set :user, "ubuntu"
ssh_options[:keys] = "~/.ssh/jalinsuara.pem"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end