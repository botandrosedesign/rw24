$turnstile_test_success = true

Net::HTTP.singleton_class.prepend(Module.new do
  def post_form(uri, params = {})
    if uri.to_s == "https://challenges.cloudflare.com/turnstile/v0/siteverify"
      Struct.new(:body).new(%({"success":#{$turnstile_test_success}}))
    else
      super
    end
  end
end)

Before do
  $turnstile_test_success = true
end

Given("Turnstile will reject the next submission") do
  $turnstile_test_success = false
end
