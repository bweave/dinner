Rails.application.routes.draw do
  resources :dinners
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dinners#index"
end
