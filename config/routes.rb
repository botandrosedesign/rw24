ActionController::Routing::Routes.draw do |map|
  map.resource :registrations, :controller => "teams", :path_prefix => "join", :only => [:show, :create], :collection => { :payment => :post }

  map.leader_board "leader-board", :controller => "teams", :action => "index"

  map.resources :teams, :path_prefix => "admin",
    :name_prefix => "admin_global_",
    :namespace   => "admin/"

  map.resources :teams, :path_prefix => "admin/sites/:site_id",
    :controller  => "teams",
    :name_prefix => "admin_site_",
    :namespace   => "admin/"

  map.resources :riders, :path_prefix => "admin",
    :name_prefix => "admin_global_",
    :namespace   => "admin/"

  map.resources :riders, :path_prefix => "admin/sites/:site_id",
    :controller  => "riders",
    :name_prefix => "admin_site_",
    :namespace   => "admin/"
end
