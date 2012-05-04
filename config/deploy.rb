set :application, "rw24"
set :asset_paths, "public/userfiles"
role :production, "www@riverwest24.com:22022"
set :rvm_ruby_string, "ree-2011.03@rw24"

desc "Clear the static cache"
task :clear_cache, :roles => :production do
  run "cd #{application} && rake clear_cache"
end
after 'deploy', 'clear_cache'

