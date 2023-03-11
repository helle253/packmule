Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :homepage, controller: 'homepage'
  namespace :admin do
    resource :session
    resource :dashboard, controller: 'dashboard'
  end
end
