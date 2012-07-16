Rw24::Application.routes.draw do
  match "jobs" => DelayedJobWeb, :anchor => false

  get "admin" => redirect("/admin/sites/1")

  root :to => "articles#index"

  resources :points

  match "leader-board/:year" => "teams#index", :year => nil, :as => "leader_board"
  match "leader-board/:year/:position" => "teams#show", :as => "leader_board_laps"

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
end
