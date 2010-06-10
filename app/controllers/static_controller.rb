class StaticController < BaseController
  before_filter :guess_section

  def dispatch
    render "/static"+request.env["rack.static_path"], :layout => true
  end
end
