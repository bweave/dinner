class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: %i[create new]
  before_action :authenticate_user!, only: %i[destroy]

  def new
  end

  def create
    @user = User.unscoped.authenticate_by(email: params[:user][:email].downcase, password: params[:user][:password])

    if @user
      if @user.unconfirmed?
        redirect_to new_confirmation_path, alert: "You must confirm your email before you can sign in."
      else
        after_login_path = session[:user_return_to] || menus_path
        login @user
        remember(@user) if params[:user][:remember_me] == "1"
        flash[:success] = "Logged in."
        redirect_to after_login_path 
      end
    else
      flash.now[:alert] = "Incorrect email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    forget(current_user)
    logout
    redirect_to root_path
  end
end
