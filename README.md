# Niu foods

Proyecto de cadena de restaurantes y actualización de estado de los dispositivos 

## Empezando 🚀

1. Debes clonar el repositorio
```bash
git clone https://github.com/danielJL19/niu_foods.git
```

## Instalación

1. Instalación de gemas y dependencias
```bash
bundle install
```
2. Hacer una copia del archivo .env.example a .env para las variables de entorno
```bash 
cp .env.example .env
```
3. Debes crear un usuario y password con postgres, le adjunto el comando
```bash 
CREATE ROLE niu_foods LOGIN PASSWORD 'abc.123';
ALTER USER niu_foods CREATEDB;
```
5. Creación de base de datos 
```bash 
env $(cat .env|xargs) rails db:create
```
4. Ejecución de migraciones del proyecto 
```bash 
env $(cat .env|xargs) rails db:migrate
```
5. Levantar servidor local en conjunto a las variables de entorno
```bash 
env $(cat .env|xargs) rails s 
```

## Rake para actualizar estado de restaurantes
```bash 
env $(cat .env|xargs) bundle exec restaurants_control:update_restaurant_status_based_on_device_status
```

## Diagrama de Conexión (alto nivel)

<img width="1163" height="631" alt="imagen" src="https://github.com/user-attachments/assets/c7ac330a-dada-4b7a-a4e9-920ada2a9eea" />

## SCRIPT DE SIMULACIÓN
EL SCRIPT ENVIA PETICIONES DE ACTUALIZACIÓN DE LOS DISPOSITIVOS DEL RESTAURANTE, LO QUE HACE ES ENVIAR ESTADOS(MAINTENANCE, PROBLEMS O OPERATIONAL) DE FORMA ALEATORIA A UNO DE LOS DISPOSITIVOS(POS O IMPRESORA DE COCINA), ELEGIDOS POR EL USUARIO,ES DECIR, EN BASE AL INPUT. ADEMÁS SE SOPORTAR IDS QUE NO EXISTEN PARA ENVIAR UN ERROR DE MENSAJE PERSONALIZADO

## Diseño de base de datos 
<img width="1264" height="865" alt="imagen" src="https://github.com/user-attachments/assets/bb39c557-ec92-4ac7-9760-2b8ea4306fc5" />

## Pruebas con curl
```bash
Creación de restaurante
curl -X POST -H "Content-Type: application/json" \ -d '{"name": "restaurante 1", "address": "dirección 1", "status": 0}' \ http://localhost:3000/api/v1/restaurants
Creación de dispositivo
curl -X POST -H "Content-Type: application/json" \ -d '{"name": "pos 1", "device_type": 0}' \ http://localhost:3000/api/v1/devices
Creación de dispositivo para el restaurante
curl -X POST -H "Content-Type: application/json" \ -d '{"restaurant_id": 1, "device_id": 1, "status": 0, "description": "example"}' \ http://localhost:3000/api/v1/restaurants/1/restaurant_devices
Actualizar estado de dispositivo de restaurante
curl -X PATCH -H "Content-Type: application/json" \
  -d '{"status": 2, "description": "fue cambiado"}' \
  http://localhost:3000/api/v1/restaurants/1/restaurant_devices/1/update_status
```

