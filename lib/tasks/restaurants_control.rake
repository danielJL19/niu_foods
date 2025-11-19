namespace :restaurants_control do
  desc "Actualización de estado de restaurantes según el estado de sus dispositivos"
  task update_restaurant_status_based_on_device_status: :environment do
    logger = CustomLogger.logger
    @restaurants = Restaurant.all
    @restaurants.each do |restaurant|

      # Obtiene todos los dispositivos POS y Kitchen Printers del restaurante
      all_pos = restaurant.restaurant_devices.pos_devices
      all_kitchen_printers = restaurant.restaurant_devices.kitchen_printers 

      # Según la cantidad de los dispositivos POS y Kitchen Printers para actualizar el estado del restaurante
      pos_operational = all_pos.where(status: 0).count
      pos_non_operational = all_pos.where(status: 1..2).count
      kitchen_printer_operational = all_kitchen_printers.where(status: 0).count
      kitchen_printer_non_operational = all_kitchen_printers.where(status: 1).count

      if pos_operational == 0 && kitchen_printer_operational == 0
        restaurant.update(status: 2) # problemas
        logger.info "El restaurante #{restaurant.name}: #{restaurant.id} está en estado de problemas."
      elsif pos_operational == 1 && kitchen_printer_operational == 1
        restaurant.update(status: 1) # Advertencia
        logger.info "El restaurante #{restaurant.name}: #{restaurant.id} está en estado de advertencia."
      elsif pos_operational >= 2 || kitchen_printer_operational >= 2
        restaurant.update(status: 0) # Operacional
        logger.info "El restaurante #{restaurant.name}: #{restaurant.id} está en estado operacional."
      end
    end
  end
end