class DinnersController < ApplicationController
  before_action :set_dinner, only: %i[ show edit update destroy ]

  # GET /dinners or /dinners.json
  def index
    @dinners = Dinner.all
  end

  # GET /dinners/1 or /dinners/1.json
  def show
  end

  # GET /dinners/new
  def new
    @dinner = Dinner.new
  end

  # GET /dinners/1/edit
  def edit
  end

  # POST /dinners or /dinners.json
  def create
    @dinner = Dinner.new(dinner_params)

    respond_to do |format|
      if @dinner.save
        format.html { redirect_to dinner_url(@dinner), notice: "Dinner was successfully created." }
        format.json { render :show, status: :created, location: @dinner }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dinner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dinners/1 or /dinners/1.json
  def update
    respond_to do |format|
      if @dinner.update(dinner_params)
        format.html { redirect_to dinner_url(@dinner), notice: "Dinner was successfully updated." }
        format.json { render :show, status: :ok, location: @dinner }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dinner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dinners/1 or /dinners/1.json
  def destroy
    @dinner.destroy

    respond_to do |format|
      format.html { redirect_to dinners_url, notice: "Dinner was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dinner
      @dinner = Dinner.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dinner_params
      params.require(:dinner).permit(:name, :last_suggested_at)
    end
end
