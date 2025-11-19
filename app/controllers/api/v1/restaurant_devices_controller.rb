class Api::V1::RestaurantDevicesController < ApplicationController

  def update_status
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_device = @restaurant.restaurant_devices.find_by(device_id: params[:id])
    if @restaurant_device.update(restaurant_device_params)
      render json: @restaurant_device, status: :ok
      RestaurantDeviceHistory.create(
        restaurant_device: @restaurant_device,
        status: @restaurant_device.status,
        changed_at: Time.current
      )
    else
      render json: @restaurant_device.errors, status: :unprocessable_entity
    end
  end

  private 

  def restaurant_device_params
    params.require(:restaurant_device).permit(:status)
  end
end
