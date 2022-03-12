class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: %i[create new]
  before_action :authenticate_user!, only: %i[destroy]

  def new
  end

  def create
    @user = User.unscoped.authenticate_by(email: params[:user][:email].downcase, password: params[:user][:password])
    return unable_to_authenticate if @user.blank?

    if @user.confirmed?
      login @user
      remember(@user) if params[:user][:remember_me] == "1"
      flash[:success] = "Logged in."
      redirect_to after_login_path
    else
      redirect_to new_confirmation_path, alert: "Please confirm your email first."
    end
  end

  def destroy
    forget(current_user)
    logout
    redirect_to root_path
  end

  private

  def after_login_path
    session[:user_return_to] || menus_path
  end

  def unable_to_authenticate
    flash.now[:alert] = "Incorrect email or password."
    render :new, status: :unprocessable_entity
  end
end
