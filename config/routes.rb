Bcad::Application.routes.draw do
  get "automobiles" => "home#index"
  get "automobiles/new" => "home#index"
  get "automobiles/:id" => "home#index"
  get "automobiles/:id/edit" => "home#index"

  get "solicitations" => "home#index"
  get "solicitations/new" => "home#index"
  get "solicitations/:id" => "home#index"
  get "solicitations/:id/edit" => "home#index"

  get "registrants" => "home#index"
  get "registrants/new" => "home#index"
  get "registrants/:id" => "home#index"
  get "registrants/:id/edit" => "home#index"

  get "users" => "home#index"
  get "users/new" => "home#index"
  get "users/:id" => "home#index"
  get "users/:id/edit" => "home#index"

  get "profile" => "home#index"

  get "login" => "sessions#new", :as => :login
  post "login" => "sessions#create"
  
  get "logout" => "sessions#destroy", :as => :logout
  
  get "reset/:code" => "passwords#edit", :as => :reset
  put "reset/:code" => "passwords#update"
  
  scope "/api" do
    resources :automobiles, :only => [ :index, :show, :update, :destroy ], defaults: { format: :json } do
      resources :solicitations, :only => [ :index, :show, :update, :destroy ], defaults: { format: :json } do
        resources :employers, :except => [ :new, :edit, :create ], defaults: { format: :json }
        resources :residences, :except => [ :new, :edit, :create ], defaults: { format: :json }
      end
      resources :photos, :only => [ :index, :show, :update, :destroy ], defaults: { format: :json }
    end

    resources :solicitations, :only => [ :index, :show, :update, :destroy ], defaults: { format: :json } do
      resources :employers, :except => [ :new, :edit, :create ], defaults: { format: :json }
      resources :residences, :except => [ :new, :edit, :create ], defaults: { format: :json }
    end
  
    resources :users, :except => [ :new, :edit, :create ], defaults: { format: :json } do
      resources :telephones, :except => [ :new, :edit, :create ], defaults: { format: :json }
      resources :logins, :only => [ :index, :show, :destroy ], defaults: { format: :json }
    end

    resources :registrants, :only => [ :index, :show, :update, :destroy ], defaults: { format: :json }
  end

  root :to => 'home#index'
end
