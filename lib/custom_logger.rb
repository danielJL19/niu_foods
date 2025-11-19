require "logger"

class CustomLogger
  def self.logger
    @logger ||= Logger.new(Rails.root.join("log", "restaurants_control.log"))
  end
end