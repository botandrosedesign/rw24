Given "I am logged in as an admin" do
  user = create_admin_account
  visit "/admin"
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Login"
  step 'I am on the admin overview page'
end

Given "I am logged in as {string} with password {string}" do |email, password|
  visit "/"
  click_link "Login"
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Login"
  step 'I should see ""'
end

def create_admin_account
  user = @site.users.where(email: "admin@riverwest24.com").first_or_initialize
  user.update! FactoryBot.attributes_for(:user, {
    first_name: "Admin",
    last_name: "Account",
    email: "admin@riverwest24.com",
    admin: true,
  })
  user
end
