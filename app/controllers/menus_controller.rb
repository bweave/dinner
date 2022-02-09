class MenusController < ApplicationController
  before_action :authenticate_user!
  before_action :set_menu, only: %i[ show edit update destroy ]

  def index
    starts_at, direction = if params[:past_menus]
                         [[..Time.current.beginning_of_week], :desc]
                       else
                         [[Time.current.beginning_of_week..], :asc]
                       end
    @menus = Menu.where(starts_at: starts_at).includes(:recipes).order(starts_at: direction).limit(10)
  end

  def show
  end

  def new
    latest_menu = Menu.order(starts_at: :desc).first_or_initialize(starts_at: Time.current.next_week)
    next_week = latest_menu.starts_at.next_week
    @recipes = Recipe.all
    @menu = Menu.new(starts_at: next_week)
  end

  def edit
    @recipes = Recipe.all
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.ends_at = @menu.starts_at.end_of_week

    respond_to do |format|
      if @menu.save
        format.html { redirect_to menus_url }
        format.json { render :show, status: :created, location: @menu }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      ends_at = Time.parse(menu_params[:starts_at]).end_of_week
      if @menu.update(menu_params.merge(ends_at: ends_at))
        format.html { redirect_to menus_url }
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to menus_url }
      format.json { head :no_content }
    end
  end

  private
    def set_menu
      @menu = Menu.find(params[:id])
    end

    def menu_params
      params.require(:menu).permit(:starts_at, recipe_ids: [])
    end
end
