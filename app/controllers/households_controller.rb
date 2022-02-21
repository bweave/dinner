class HouseholdsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_household, only: %i[show edit update]

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @household.update(household_params)
        format.html { redirect_to household_url(@household) }
        format.json { render :show, status: :ok, location: @household }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @household.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_household
    @household = Household.includes(:users).find(Household.current.id)
  end

  def household_params
    params.require(:household).permit(:name)
  end
end
