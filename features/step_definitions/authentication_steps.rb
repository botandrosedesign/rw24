Given /^the "Admin" user account exists$/ do
  user = User.make :first_name => "Finneus",
    :last_name => "Flubberbuster",
    :email => "finneus@botandrose.com",
    :password => "secret"
  user.roles << Rbac::Role.new(:name => "superuser")
  @site.users << user
end

Given /^I am logged in as an Admin$/ do
  step 'the "Admin" user account exists'
  step 'I am on the admin page'
  step 'I fill in "Email" with "finneus@botandrose.com"'
  step 'I fill in "Password" with "secret"'
  step 'I press "Login"'
  step 'I am on the admin overview page'
end

