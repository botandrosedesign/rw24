Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resource :account do
    resource :email do
      get :confirmation, on: :member
    end
    resources :confirmations
  end

  resources :points do
    collection do
      get "bonus", action: :bonuses, as: "bonuses"
      get "bonus/:key", :action => :bonus, :key => /[a-z0-9]+/, :as => "bonus"
      put "bonus/:key", :action => :update_bonuses, :key => /[a-z0-9]+/, :as => "update_bonuses"
      post "bonus/:key", :action => :award_bonus_to_all, :key => /[a-z0-9]+/, :as => "award_bonus_to_all"
      post "assign_all_bonuses_bonuses"
    end
    post :split, on: :member
  end

  get "leader-board/:year" => "teams#index", :year => nil, :as => "leader_board"
  get "leader-board/:year/:position" => "teams#show", :as => "leader_board_laps"

  match "/admin/jobs" => DelayedJobWeb, anchor: false, via: [:get, :post]

  get "admin" => redirect("/admin/site")

  namespace :admin do
    resource :confirmation_email
    resources :races do
      resources :bonuses do
        put "", action: :sortable, on: :collection
        post :delete_all, on: :collection
      end
      resources :teams, except: :show do
        post :send_confirmation_emails, :on => :collection
      end
    end
    resources :users do
      post :resend_confirmation
    end
    resource :database
  end
end
