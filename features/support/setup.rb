Before do
  @site = Site.make
  @home = Page.make :site => @site, :title => "Home"

  @admin = User.make :email => "admin@riverwest24.com"
  @admin.roles << Rbac::Role.new( :name => "superuser" )
  @site.users << @admin
end
