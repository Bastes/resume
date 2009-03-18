load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

desc "Restarting after deployment"
task :after_deploy, :roles => [:app, :db, :web] do
 run "sed 's/# ENV\\[/ENV\\[/g' #{deploy_to}/current/config/environment.rb > #{deploy_to}/current/config/environment.temp"
 run "mv #{deploy_to}/current/config/environment.temp #{deploy_to}/current/config/environment.rb"
end

desc "Sets production database configuration file."
task :setup_production_database_configuration do
  database_password = Capistrano::CLI.password_prompt("Database password: ")
  require 'yaml'
  spec = { "production" => {
    "adapter"  => "mysql",
    "encoding" => "utf8",
    "database" => database_schema,
    "username" => database_username,
    "password" => database_password,
    "host"     => database_host,
    "port"     => database_port } }
  run "mkdir -p #{shared_path}/config"
  put(spec.to_yaml, "#{shared_path}/config/database.yml")
end
after "deploy:setup", :setup_production_database_configuration

desc "Sets production configuration files (admin password...)."
task :setup_production_configuration do
  app_admin_password = Capistrano::CLI.password_prompt("App admin password: ")
  run "mkdir -p #{shared_path}/config/initializers"
  put "ADMIN_PASSWORD = '#{app_admin_password}'",
      "#{shared_path}/config/initializers/admin_password.rb"
end
after "deploy:setup", :setup_production_configuration

desc "Copy production database configuration file."
task :copy_production_database_configuration do
  run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end
after "deploy:update_code", :copy_production_database_configuration

desc "Copy production configuration files (admin password...)."
task :copy_production_configuration do
  run "cp #{shared_path}/config/initializers/admin_password.rb #{release_path}/config/initializers/admin_password.rb"
end
after "deploy:update_code", :copy_production_configuration

desc "Fix scrip/spin unexecutability."
task :fix_script_perms do
  run "chmod 755 #{latest_release}/script/spin"
end
after "deploy:update_code", :fix_script_perms
