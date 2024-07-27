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
    sh "bundle exec whenever --update-crontab rw24"
    sh "bundle exec foreman export systemd-user --app rw24"
  end
end

desc "clear all cached pages"
task :clear_cache => :environment do
  Site.all.each(&:touch)
end

desc "statically cache leaderboard"
task :cache_leaderboard => :environment do
  @race = Race.current
  body = ApplicationController.render template: "teams/index", assigns: {
    site: Site.first,
    section: Section.first,
    race: @race,
    teams: @race.teams.leader_board,
  }
  
  FileUtils.mkdir_p "public/leader-board"
  File.write "public/leader-board/#{@race.year}.html", body
end

