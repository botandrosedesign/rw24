Given /^the "we're full" page exists$/ do
  @join = Page.make :site => @site, :title => "Join", :permalink => "join", :single_article_mode => false
  @full = Article.make :site => @site, :section => @join, :title => "closed"
  @full.body = File.read("#{Rails.root}/features/support/full.html")
  @full.save!
end
