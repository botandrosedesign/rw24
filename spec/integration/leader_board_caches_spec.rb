ENV['RAILS_ENV'] = "production"

require 'spec_helper'
require "rack/test"

describe "LeaderBoardCaches" do
  it "caches" do
    include Rack::Test::Methods
    get "/leader-board"
    f = File.open "public/leader-board.html", "w"
    f << response.body
    f.close
  end
end
