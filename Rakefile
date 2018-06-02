# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

if Rails.env.production?
  task :restart => :clear_cache do
    sh "bundle exec foreman export upstart-user"
    sh "restart rw24"
  end
end

