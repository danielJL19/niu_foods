class Api::V1::DevicesController < ApplicationController

  def index
    @devices = Device.all
    render json: @devices
  end

  def create
    @device = Device.new(device_params)
    if @device.save
      render json: @device, status: :created
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  private

  def device_params
    params.require(:device).permit(:name)
  end
end
