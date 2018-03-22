Given "I am logged in as an admin" do
  create_admin_account
  visit "/admin/sites/1" # stupid phantomjs hates double redirects a second time :(
  fill_in "Email", with: "finneus@botandrose.com"
  fill_in "Password", with: "secret"
  click_button "Login"
  step 'I am on the admin overview page'
end

def create_admin_account
  @site.users << FactoryBot.create(:user, {
    first_name: "Finneus",
    last_name: "Flubberbuster",
    email: "finneus@botandrose.com",
    password: "secret",
    roles: [Rbac::Role.new(name: "superuser")],
  })
end

