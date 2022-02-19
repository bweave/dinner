module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :current_user
    before_action :current_household
    helper_method :current_user
    helper_method :current_household
    helper_method :user_signed_in?
  end

  def login(user)
    reset_session
    user.regenerate_session_token
    session[:current_user_session_token] = user.reload.session_token
  end

  def logout
    user = current_user
    reset_session
    user.regenerate_session_token
  end

  def redirect_if_authenticated
    redirect_to menus_path, alert: "You are already logged in." if user_signed_in?
  end

  def authenticate_user!
    store_location
    redirect_to login_path, alert: "You need to login to access that page." unless user_signed_in?
  end

  def forget(user)
    cookies.delete :remember_token
    user.regenerate_remember_token
  end

  def remember(user)
    user.regenerate_remember_token
    cookies.permanent.encrypted[:remember_token] = user.remember_token
  end

  def store_location
    session[:user_return_to] = request.original_url if request.get? && request.local?
  end

  private

  def current_user
    Current.user ||= if session[:current_user_session_token].present?
                       User.unscoped.find_by(session_token: session[:current_user_session_token])
                     elsif cookies.permanent.encrypted[:remember_token].present?
                       User.unscoped.find_by(remember_token: cookies.permanent.encrypted[:remember_token])
                     end
  end

  def current_household
    Current.household = current_user&.household
  end

  def user_signed_in?
    Current.user.present?
  end
end
