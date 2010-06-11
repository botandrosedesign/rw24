ActionController::Routing::Routes.draw do |map|
  map.resource :registrations, :controller => 'registrations', :path_prefix => "join", :only => [:show, :create], :collection => { :payment => :post }
end
