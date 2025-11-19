class AddDeviceTypeToDevices < ActiveRecord::Migration[7.2]
  def change
    add_column :devices, :device_types, :integer
  end
end
