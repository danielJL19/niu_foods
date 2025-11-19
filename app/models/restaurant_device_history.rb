class RestaurantDeviceHistory < ApplicationRecord
  belongs_to :restaurant_device
  belongs_to :restaurant

  enum status: { operational: 0, maintenance: 1, problems: 2 }
end
