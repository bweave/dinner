class PasswordsController < ApplicationController
  before_action :redirect_if_authenticated

  def new
  end

  def create
    @user = User.unscoped.find_by(email: params[:user][:email].downcase)

    if @user.present?
      if @user.confirmed?
        @user.send_password_reset_email!
        redirect_to root_path, notice: "If that user exists we've sent instructions to their email."
      else
        redirect_to new_confirmation_path, alert: "Please confirm your email first."
      end
    else
      redirect_to root_path, notice: "If that user exists we've sent instructions to their email."
    end
  end

  def edit
    @user = User.unscoped.find_by(password_reset_token: params[:password_reset_token])

    if @user.present? && @user.unconfirmed?
      redirect_to new_confirmation_path, alert: "You must confirm your email before you can sign in."
    elsif @user.nil? || @user.password_reset_token_has_expired?
      redirect_to new_password_path, alert: "Invalid or expired token."
    end
  end

  def update
    @user = User.unscoped.find_by(password_reset_token: params[:password_reset_token])
    result = ResetPassword.new(password_params: password_params, user: @user).call

    if result.ok?
      redirect_to login_url, notice: "Password updated successfully."
    else
      handle_non_happy_path_update(result)
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def handle_non_happy_path_update(result)
    case result.status
    when :not_found
      flash.now[:alert] = "We couldn't find a user with that token."
      render :new, status: :unprocessable_entity
    when :error
      flash.now[:alert] = "Password could not be updated. Please, try again."
      render :edit, status: :unprocessable_entity
    when :unconfirmed
      redirect_to new_confirmation_url, notice: "You must confirm your email before you can sign in."
    when :expired_token
      redirect_to(new_password_url, notice: "Expired password reset token.")
    end
  end
end
