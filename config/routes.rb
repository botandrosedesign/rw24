Rw24::Application.routes.draw do |map|
  match "jobs" => DelayedJobWeb, :anchor => false

  get "admin" => redirect("/admin/sites/1")

  root :to => "articles#index"

  map.resources :points

  map.leader_board "leader-board/:year", :controller => "teams", :action => "index", :year => nil
  map.leader_board_laps "leader-board/:year/:position", :controller => "teams", :action => "show"

  namespace :admin do
    resources :sites do
      resources :races do
        resources :teams do
          post :send_confirmation_emails, :on => :collection
          resources :riders
        end
      end
    end
  end

  map.resources :races, :path_prefix => "admin",
    :name_prefix => "admin_global_",
    :namespace   => "admin/"

  map.resources :races, :path_prefix => "admin/sites/:site_id",
    :controller  => "teams",
    :name_prefix => "admin_site_",
    :namespace   => "admin/"

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
