class Api::V1::RestaurantDevicesController < ApplicationController

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_devices = @restaurant.restaurant_devices
    render json: @restaurant_devices.as_json(include: {
      device: { only: [:name, :device_types] }
    }), status: :ok
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_device = @restaurant.restaurant_devices.new(restaurant_device_params)
    if @restaurant_device.save
      render json: @restaurant_device, status: :created
    else
      render json: @restaurant_device.errors, status: :unprocessable_entity
    end
  end

  def update_status
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_device = @restaurant.restaurant_devices.find_by(id: params[:id])

    if @restaurant_device.update(restaurant_device_params)
      
      RestaurantDeviceHistory.create(
        restaurant_device_id: @restaurant_device.id,
        restaurant_id: @restaurant.id,
        status: @restaurant_device.status,
        description: @restaurant_device.description
      )
      render json: @restaurant_device, status: :ok
    else
      render json: @restaurant_device.errors.full_messages, status: :unprocessable_entity
    end
  end

  private 

  def restaurant_device_params
    params.require(:restaurant_device).permit(:status, :description)
  end
end
