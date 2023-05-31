Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resource :account do
    resources :confirmations
  end

  resources :points do
    collection do
      get "bonus", action: :bonuses, as: "bonuses"
      get "bonus/:key", :action => :bonus, :key => /[a-z0-9]+/, :as => "bonus"
      put "bonus/:key", :action => :update_bonuses, :key => /[a-z0-9]+/, :as => "update_bonuses"
      post "assign_all_bonuses_bonuses"
    end
    post :split, on: :member
  end

  get "leader-board/:year" => "teams#index", :year => nil, :as => "leader_board"
  get "leader-board/:year/:position" => "teams#show", :as => "leader_board_laps"

  match "/admin/jobs" => DelayedJobWeb, anchor: false, via: [:get, :post]

  get "admin" => redirect("/admin/site")

  namespace :admin do
    resources :races do
      resources :bonuses do
        put :reposition, on: :collection
        post :delete_all, on: :collection
      end
      resources :teams, except: :show
    end
    resources :users do
      post :resend_confirmation
    end
    resource :database
  end
end
