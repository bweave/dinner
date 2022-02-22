class InvitationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @invitation = Invitation.new(household: Household.current, created_by: User.current)
  end

  def create
    @invitation = Invitation.new(invitation_params)

    respond_to do |format|
      if @invitation.save
        @invitation.send_invitation_email
        flash.now[:success] = "Invitation sent to #{@invitation.email}."
        format.turbo_stream
        format.html { redirect_to household_path(@invitation.household) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @invitation = Invitation.find_by(token: params[:token])

    if @invitation.blank?
      redirect_to root_path, alert: "Invalid invitation" 
    elsif @invitation.expired_token?
      redirect_to root_path, alert: "Expired invitation"
    else
      @invitation.build_user(email: @invitation.email, household_id: @invitation.household.id)
    end
  end

  def update
    @invitation = Invitation.find_by(token: update_invitation_params.delete(:token))
    
    if @invitation.update(update_invitation_params.merge(accepted_at: Time.current))
      @invitation.user.send_confirmation_email!
      redirect_to root_url, notice: "Please check your email for confirmation instructions."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:created_by_id, :household_id, :email)
  end

  def update_invitation_params
    params.require(:invitation).permit(:token, user_attributes: [:first_name, :last_name, :password, :password_confirmation, :email, :household_id])
  end
end
