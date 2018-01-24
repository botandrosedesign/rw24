Given /^the "Admin" user account exists$/ do
  user = FactoryGirl.create :user,
    :first_name => "Finneus",
    :last_name => "Flubberbuster",
    :email => "finneus@botandrose.com",
    :password => "secret"
  user.roles << Rbac::Role.new(:name => "superuser")
  @site.users << user
end

Given /^I am logged in as an Admin$/ do
  step 'the "Admin" user account exists'
  visit "/admin/sites/1" # stupid phantomjs hates double redirects a second time :(
  fill_in "Email", with: "finneus@botandrose.com"
  fill_in "Password", with: "secret"
  click_button "Login"
  step 'I am on the admin overview page'
end

