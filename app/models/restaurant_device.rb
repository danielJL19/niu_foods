class RestaurantDevice < ApplicationRecord
  belongs_to :restaurant
  belongs_to :device
  has_many :restaurant_device_histories
  validates :status, inclusion: { in: 0..2 }

  enum status: { operational: 0, maintenance: 1, warning: 2 }
end
