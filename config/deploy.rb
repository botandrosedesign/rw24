set :application, "rw24"
role :production, "www@riverwest24.com:22022"

desc "Clear the static cache"
task :clear_cache, :roles => :production do
  run "cd #{application} && rake clear_cache"
end
after 'deploy', 'clear_cache'

