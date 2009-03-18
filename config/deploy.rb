# setting git repository informations
set :scm,                   "git"
set :repository,            "git@github.com:Bastes/resume.git"
set :scm_username,          "Bastes"
set :branch,                "dreamhost"
set :git_enable_submodules, 1 # this app needs its submodules

# setting dreamhost host informations
set :user,            "bastes_resume"
set :domain,          "hades.dreamhost.com"
set :project,         "resume"
set :application,     "resume.brouillon-de-culture.com"
set :application_dir, "/home/#{user}/#{application}"

# setting dreamhost database informations
set :database_schema,   "bastes_resume_production"
set :database_username, "bastes_resume"
set :database_host,     "mysql.brouillon-de-culture.com"
set :database_port,     3306

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

# deploy config
set :deploy_to,  application_dir
set :deploy_via, :remote_cache

# additional settings
ssh_options[:forward_agent] = true
ssh_options[:keys]          = %w(~/.ssh/id_rsa)
set :chmod755,  "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false

