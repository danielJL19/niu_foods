class CreateRestaurantDevices < ActiveRecord::Migration[7.2]
  def change
    create_table :restaurant_devices do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :device, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
