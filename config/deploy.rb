#
# Capistrano配置脚本
# 功能：1.远程同步git服务器代码
#

require "bundler/capistrano"
require 'rvm/capistrano'
# 配置
set :user, 'nagae-memooff'                      # ssh用户名
set :password, '1namiken'                # ssh密码
set :web_servers,     '133.242.187.55'       # web服务器
set :app_servers,     '133.242.187.55'       # 应用服务器
set :db_servers_main, '133.242.187.55'   # 主数据库服务器
set :db_servers,      '133.242.187.55'        # 从数据库服务器
set :domain,          '133.242.187.55'            # 域名
set :application, "blog_nagamemo"          # 应用名称
set :port, 22
       
#===============================================================================================================
role :web, web_servers                             # Your HTTP server, Apache/etc
role :app, app_servers                              # This may be the same as your `Web` server
role :db,  db_servers_main, :primary => true        # This is where Rails migrations will run
role :db,  db_servers

#================================================================================================================
# default_run_options[:pty] = true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# miscellaneous options 
# git配置
set :deploy_via, :remote_cache
set :scm, 'git'                   # scm软件管理配置
set :branch, 'master'             # 分支
set :scm_verbose, true            # 是否建立current目录

# 其他
set :use_sudo, false             # 是否使用echo 'tsoftime' |sudo -S 
default_run_options[:pty] = true  # 开启pty

set :repository,  "git@github.com:nagae-memooff/BlogNagamemo.git"             # git仓库 
set :deploy_to, "/home/nagae-memooff/rails/blog_nagamemo"             # 服务器80端口应用路径
# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# 任务
# Capistrano自带很多任务，可以自定义
# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_echo 'tsoftime' |sudo -S} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end



# 自定义nginx相关命令
namespace :nginx do
  # 重启Passenger
  desc "cause Passenger to initiate a restart"
  task :restart do 
    run "touch #{current_path}/tmp/restart.txt"
  end

  # 启动nginx
  desc "start nginx" 
  task :start do 
    run "echo '1namiken' |sudo -S /home/nagae-memooff/opt/nginx/sbin/nginx"
  end 

  # 重启nginx
  desc "restart nginx"
  task :restart do 
    run "echo '1namiken' |sudo -S /home/nagae-memooff/opt/nginx/sbin/nginx -s reload"
  end 

  # 杀死nginx
  desc "shut down nginx"
  task :stop do 
    run "echo '1namiken' |sudo -S pkill -9 nginx"
  end 
end

# 自定义数据库相关命令
namespace :db do
  # create数据库
  desc "rake db:create"
  task :create do
    run "cd #{current_path} && rake db:create RAILS_ENV=production"
  end

  # migrate database
  desc "migrate database"
  task :migrate do
    run "cd #{current_path} && rake db:migrate RAILS_ENV=production"
  end

  desc "reload the database with seed data"
  task :seed do 
    run "cd #{current_path}; rake db:seed RAILS_ENV=production"
  end
end

# 在更新代码之后，执行bundle install
after "deploy:update_code",:bundle_install, :complie_asset, :restart_nginx

desc "complie asset files"
task :complie_asset do
  run "cd #{release_path} && rake assets:precompile RAILS_ENV=production"
end

desc "install the necessary preprequisites"
task :bundle_install do 
  run "cd #{release_path} &&  bundle install"
end 

desc "restart nginx"
task :restart_nginx do 
   run "echo '1namiken' |sudo -S /home/nagae-memooff/opt/nginx/sbin/nginx -s reload"
end 


set :rvm_ruby_string, "ruby-1.9.3-p484"#@#{application}"

before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'
