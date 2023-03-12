Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homepage#show'
  resource :homepage, controller: 'homepage'
  namespace :admin do
    resource :session, only: %i[new create]
    resource :dashboard, controller: 'dashboard', only: :show
  end

  namespace :user do
    resource :login, controller: 'login', only: %i[new create]
    resources :login_token, only: :show
  end

  resource :logout, controller: 'logout', only: :show
end
