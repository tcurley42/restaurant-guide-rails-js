class RestaurantsController < ApplicationController
  before_action :require_login
  def new
    @restaurant = Restaurant.new
  end

  def show
    @restaurant = Restaurant.find_by(id: params[:id])
    redirect_if_nil
  end

  def index
    @restaurants = Restaurant.all
    respond_to do |format|
      format.html {render :index}
      format.json {render json: @restaurants, status: 200}
    end

  end

  def edit
    @restaurant = Restaurant.find_by(id: params[:id])
    redirect_if_nil
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if (!@restaurant.save)
      serialized = RestaurantSerializer.new(@restaurant).as_json
      serialized["errors"] = @restaurant.errors.full_messages
      render json: serialized, status: 201
    else
      render json: @restaurant, status: 201
    end
  end

  def update
    @restaurant = Restaurant.find_by(id: params[:id])
    redirect_if_nil

    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(@restaurant)
    else
      render :edit
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :phone, :address, :city, :state, :price)
  end

  def redirect_if_nil
    if @restaurant.nil?
      redirect_to restaurants_path
    end
  end
end
