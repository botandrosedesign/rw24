ActionController::Routing::Routes.draw do |map|
  resources :comments, :except => :index do
    post :preview, :on => :collection
  end

  namespace :admin do
    resources :sites do
      resources :comments
    end
  end
end
