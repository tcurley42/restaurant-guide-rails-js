class ExperiencesController < ApplicationController
  before_action :require_login

  def new
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    @experience = Experience.new(restaurant_id: @restaurant, user_id: current_user.id)
    if @restaurant.nil?
      redirect_to restaurants_path
    end
  end

  def edit
    @experience = Experience.find_by(id: params[:id])
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    redirect_if_nil
  end

  def create
    @experience = Experience.create(experience_params)

    redirect_to restaurant_path(@experience.restaurant)
  end

  def update
    @experience = Experience.find_by(id: params[:id])
    redirect_if_nil

    @experience.update(experience_params)
    redirect_to restaurant_path(@experience.restaurant)
  end

  private

  def experience_params
    params.require(:experience).permit(:rating, :description, :user_id, :restaurant_id)
  end

  def redirect_if_nil
    if @experience.nil?
      redirect_to restaurant_path(params[:restaurant_id])
    end
  end
end
