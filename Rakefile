# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Rw24::Application.load_tasks

if Rails.env.production?
  task :restart do
    system "bundle exec foreman export upstart-user"
    system "restart rw24"
  end
end

task "bootstrap:production:post" => [:clear_cache]

# task :default => :teaspoon

