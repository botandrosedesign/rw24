Before do
  @site = FactoryGirl.create :site, :id => 1
  @home = FactoryGirl.create :page, :site => @site, :title => "Home"

  @admin = FactoryGirl.create :user, :email => "admin@riverwest24.com"
  @admin.roles << Rbac::Role.new( :name => "superuser" )
  @site.users << @admin
end
