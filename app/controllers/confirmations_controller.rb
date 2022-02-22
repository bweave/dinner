class ConfirmationsController < ApplicationController
  before_action :redirect_if_authenticated, only: %i[create new]

  def new
    @user = User.unscoped.new
  end

  def create
    @user = User.unscoped.find_by(email: params[:user][:email].downcase)

    if @user.present? && @user.confirmation_token_is_valid?
      if @user.confirm!
        login @user
        redirect_to menus_path, success: "Your account has been confirmed."
      else
        redirect_to new_confirmation_path, alert: "Something went wrong."
      end
    else
      redirect_to new_confirmation_path, alert: "We could not find a user with that email or that email has already been confirmed."
    end
  end

  def edit
    @user = User.unscoped.find_by(confirmation_token: params[:confirmation_token])

    if @user.present? && @user.unconfirmed_or_reconfirming? && @user.confirmation_token_is_valid?
      @user.confirm!
      login @user
      redirect_to menus_path, success: "Your account has been confirmed."
    else
      redirect_to new_confirmation_path, alert: "Invalid token."
    end
  end
end
