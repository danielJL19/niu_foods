class Restaurant < ApplicationRecord

  has_many :restaurant_devices
  has_many :devices, through: :restaurant_devices

  validates :name, presence: true
  validates :address, presence: true
  validates :status, inclusion: { in: 0..2 } 
  enum status: { operational: 0, warning: 1, problems: 2 }
  # Status 0: operational, 1: warning, 2: problems
end
