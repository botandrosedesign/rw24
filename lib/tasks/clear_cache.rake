desc "clear all cached pages"
task :clear_cache => :environment do
  Site.all.each(&:touch)
end
