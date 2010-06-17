desc "clear all cached pages"
task :clear_cache => :environment do
  Admin::CachedPagesController.new.instance_eval do
    CachedPage.all.each do |page|
      self.class.expire_page page.url
      page.destroy
    end
  end
end
