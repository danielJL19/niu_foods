class RestaurantDevice < ApplicationRecord
  belongs_to :restaurant
  belongs_to :device
  has_many :restaurant_device_histories

  enum status: { operational: 0, maintenance: 1, problems: 2 }
  # Status 0: operational, 1: maintenance, 2: problems

  scope :pos_devices, -> { joins(:device).where(devices: { device_types: 0 }) }
  scope :kitchen_printers, -> { joins(:device).where(devices: { device_types: 1 }) }
end
