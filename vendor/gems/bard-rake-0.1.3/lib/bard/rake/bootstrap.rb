task :restart do
  system "touch tmp/restart.txt"
  system "touch tmp/debug.txt" if ENV["DEBUG"] == 'true'
end

desc "Bootstrap project"
task :bootstrap => %w(bootstrap:files gems:install db:create db:migrate restart)

namespace :bootstrap do
  desc "Bootstrap project to run tests"
  task :test => :bootstrap do
    system "rake gems:install db:create db:schema:load RAILS_ENV=test"
    system "rake gems:install RAILS_ENV=cucumber" unless bundler_used?
  end

  desc "Bootstrap project to run in production"
  task :production => :bootstrap do
    if File.exist?("public/stylesheets/sass") or File.exist?("app/sass")
      Sass::Plugin.options[:always_update] = true;
      Sass::Plugin.update_stylesheets
    end
    Rake::Task["asset:packager:build_all"].invoke if File.exist?("vendor/plugins/asset_packager")
  end

  task :files do
    system "git submodule sync"
    system "git submodule init"
    system "git submodule update --merge"
    system "git submodule foreach 'git checkout `git name-rev --name-only HEAD`'"
    system "cp config/database.sample.yml config/database.yml" unless File.exist?('config/database.yml')
  end
end

Rake::Task[:default].clear
desc "Bootstrap the current project and run the tests."
task :default => ["bootstrap:test", :spec, :cucumber]
