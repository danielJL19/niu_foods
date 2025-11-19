class Device < ApplicationRecord
  has_many :restaurant_devices
  has_many :restaurants, through: :restaurant_devices

  validates :name, presence: true
end
