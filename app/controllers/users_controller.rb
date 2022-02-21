class UsersController < ApplicationController
  before_action :redirect_if_authenticated, only: %i[new create]
  before_action :authenticate_user!, only: %i[edit update destroy]
  before_action :set_user, only: %i[edit show update destroy]

  def index
    # TODO: admins only!
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
    @user.build_household
  end

  def create
    @user = User.new(create_user_params)

    if @user.save
      @user.send_confirmation_email!
      redirect_to root_url(@user), notice: "Please check your email for confirmation instructions."
    else
      render :new
    end
  end

  def edit
  end

  def update
    # TODO: does this work? 😆
    if @user.authenticate(params[:user][:current_password])
      if @user.update(update_user_params)
        if params[:user][:unconfirmed_email].present?
          @user.send_confirmation_email!
          redirect_to root_path, notice: "Check your email for confirmation instructions."
        else
          redirect_to edit_user_path(current_user), notice: "Account updated."
        end
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:error] = "Incorrect password"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy
    reset_session
    redirect_to root_path, notice: "Your account has been deleted."
  end

  private

  def set_user
    @user = current_user
  end

  def create_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, household_attributes: [:name])
  end

  def update_user_params
    params.require(:user).permit(:first_name, :last_name, :current_password, :password, :password_confirmation, :unconfirmed_email, household_attributes: [:name])
  end
end
