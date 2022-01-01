Rails.application.routes.draw do
  resources :menus
  resources :dinners
  resource :suggestions, only: %w[show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "menus#index"
end
