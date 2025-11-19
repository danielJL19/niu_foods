require 'net/http'
require 'json'

def get_restaurant_devices(restaurant_id)
  uri = URI("http://localhost:3000/api/v1/restaurants/#{restaurant_id}/restaurant_devices")

  response = Net::HTTP.get_response(uri)
  body = response.body.force_encoding('UTF-8')
  devices = JSON.parse(body)
  puts "response = #{response}"
  device_ids = devices.map { |device| device["id"] }
  device_ids
  rescue StandardError => e
    puts "Error al obtener dispositivos para el restaurante #{restaurant_id}: #{e.message}"
    []
end

puts "Ingresa los IDs de los restaurantes separados por comas (por ejemplo, 1,2,3):"
input = gets.chomp
restaurant_device_ids = input.split(",").map(&:to_i)

restaurant_devices = {}
restaurant_device_ids.each do |restaurant_id|
  restaurant_devices[restaurant_id] = get_restaurant_devices(restaurant_id)
end

1.times do
  restaurant_device_ids.each do |restaurant_id|
    status = rand(0..2)

    if status == 0
      description = "El dispositivo está operativo"
    elsif status == 1
      description = "El dispositivo está en mantenimiento"
    elsif status == 2
      description = "El dispositivo tiene problemas"
    end

    id = restaurant_devices[restaurant_id].sample
    puts "Actualizando Restaurante id: #{restaurant_id}, Dispositivo id: #{id} a estado #{status} - #{description}"

    uri = URI("http://localhost:3000/api/v1/restaurants/#{restaurant_id}/restaurant_devices/#{id}/update_status")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Patch.new(uri)
    request['Content-Type'] = 'application/json'
    request.body = {status: status, description: description}.to_json
    
    response = http.request(request)
    puts "Response: #{response.code} - #{response.body}"
  end
  sleep 5
end