require "sidekiq/web"

class AdminConstraint
  def matches?(request)
    return false unless request.session[:current_user_session_token].present?
    user = User.unscoped.find_by(session_token: request.session[:current_user_session_token])
    user && user.admin?
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq", :constraints => AdminConstraint.new

  get "static_pages/home"
  resources :households, only: %i[show edit update] #=> TODO: destroy + index, new, create for admins
  resources :users
  resources :invitations, only: %i[new create edit update], param: :token
  resources :confirmations, only: %i[new create edit], param: :confirmation_token
  resources :passwords, only: %i[create edit new update], param: :password_reset_token
  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "login", to: "sessions#new"
  get "account", to: "users#edit"
  put "account", to: "users#update"
  delete "account", to: "users#destroy"

  resources :menus
  resources :recipes

  root "static_pages#home"
end
