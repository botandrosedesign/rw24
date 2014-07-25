Rails.application.routes.draw do
  match "/admin/jobs" => DelayedJobWeb, anchor: false, via: [:get, :post]

  get "admin" => redirect("/admin/sites/1")

  root :to => "articles#index"

  resources :points do
    collection do
      get "bonus", action: :bonuses, as: "bonuses"
      get "bonus/:key", :action => :bonus, :key => /[a-z0-9]+/, :as => "bonus"
    end
    post :split, on: :member
  end

  get "leader-board/:year" => "teams#index", :year => nil, :as => "leader_board"
  get "leader-board/:year/:position" => "teams#show", :as => "leader_board_laps"

  namespace :admin do
    resources :sites do
      resource :confirmation_email
      resources :races do
        resources :bonuses
        resources :teams do
          post :send_confirmation_emails, :on => :collection
          resources :riders
        end
      end
    end
  end
end
