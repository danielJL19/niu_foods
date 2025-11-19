class AddDestriptionToRestaurantDevices < ActiveRecord::Migration[7.2]
  def change
    add_column :restaurant_devices, :description, :text
  end
end
