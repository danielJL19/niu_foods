class RestaurantDevice < ApplicationRecord
  belongs_to :restaurant
  belongs_to :device
  has_many :restaurant_device_histories
  validates :status, inclusion: { in: 0..2 }
  # Status 0: operational, 1: maintenance, 2: problems
end
