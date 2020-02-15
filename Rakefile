# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task :bootstrap do
  Rake::Task["db:seed"].invoke
  Rake::Task["clear_cache"].invoke
end

if Rails.env.production?
  task :restart => :clear_cache do
    sh "bundle exec foreman export systemd-user --app rw24"
    sh "systemctl --user enable rw24.target"
    sh "systemctl --user restart rw24.target"
  end
end

desc "clear all cached pages"
task :clear_cache => :environment do
  Site.all.each(&:touch)
end
