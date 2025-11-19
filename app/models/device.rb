class Device < ApplicationRecord
  has_many :restaurant_devices
  has_many :restaurants, through: :restaurant_devices

  enum device_types: { pos: 0, kitchen_printer: 1 }
  validates :name, presence: true
end
