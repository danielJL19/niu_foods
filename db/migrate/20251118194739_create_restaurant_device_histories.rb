class CreateRestaurantDeviceHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :restaurant_device_histories do |t|
      t.references :restaurant_device, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
