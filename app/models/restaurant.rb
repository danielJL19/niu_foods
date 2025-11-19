class Restaurant < ApplicationRecord

  has_many :restaurant_devices
  has_many :devices, through: :restaurant_devices

  validates :name, presence: true
  validates :address, presence: true
  validates :status, inclusion: { in: 0..2 } 
  enum status: { operation: 0, warning: 1, problems: 2 }
end
