desc "clear all cached pages"
task :clear_cache => :environment do
  Admin::CachedPagesController.new.instance_eval do
    expire_all_cached_pages
  end
end
