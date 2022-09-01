class RedirectCell < Nacelle::Cell
  def to_url options={}
    @url = options[:url]
    render
  end
end

