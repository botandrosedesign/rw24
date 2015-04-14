class RedirectCell < BaseCell
  def to_url options={}
    @url = options[:url]
    render
  end
end

