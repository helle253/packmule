Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homepage#show'
  resource :homepage, controller: 'homepage', only: :show
  resource :about, controller: 'about', only: :show
  resource :contact, controller: 'contact', only: :show

  namespace :admin do
    resource :session, only: %i[new create]
    resource :dashboard, controller: 'dashboard', only: :show
    resource :credentials, controller: 'credentials', only: %i[edit update]
    resource :recipient_export, controller: 'recipient_export', only: %i[show]
    resources :allergens, only: %i[index new create edit update destroy] do
      get '/page/:page', action: :index, on: :collection
    end
    resources :recipient, only: %i[index edit update destroy] do
      get '/page/:page', action: :index, on: :collection
    end
    resources :shipment, only: %i[index new create edit update destroy] do
      get '/page/:page', action: :index, on: :collection
    end
    resources :recipient_shipments, only: :destroy
  end

  namespace :user do
    resource :login, controller: 'login', only: %i[new create]
    resources :login_token, only: :show
    resource :dashboard, controller: 'dashboard', only: :show
    resource :my_allergies, controller: 'allergies', only: %i[edit update]
    resources :shipments, only: :create
  end

  resources :shipment, only: %i[index show]

  resource :logout, controller: 'logout', only: :show
end
