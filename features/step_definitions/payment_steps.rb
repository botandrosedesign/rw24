Then /^I should see a PayPal form for "([^\"]+)" at "([$0-9.]+)"$/ do |item, fee|
  # get the paypal form, params
  paypal_form = Webrat::Scope::FormLocator.new(@_webrat_session, @_webrat_session.dom, 'paypal_form').locate
  action = paypal_form.send :form_action
  method = paypal_form.send :form_method
  params = paypal_form.send :params
  
  method.should == 'post'
  uri = URI.parse action

  # post the form to paypal
  agent = Mechanize.new
  agent.post(action, params)
  agent.page.uri.host.should == 'www.paypal.com'

  # verify appropriate response from paypal
  doc = Nokogiri::HTML agent.page.body
  doc.css(".items a.autoTooltip").first["title"].should == item
  doc.css(".items").text.should include("Item total #{fee}")
end

