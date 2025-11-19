# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_11_19_113404) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "device_types"
  end

  create_table "restaurant_device_histories", force: :cascade do |t|
    t.bigint "restaurant_device_id", null: false
    t.bigint "restaurant_id", null: false
    t.text "description"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_device_id"], name: "index_restaurant_device_histories_on_restaurant_device_id"
    t.index ["restaurant_id"], name: "index_restaurant_device_histories_on_restaurant_id"
  end

  create_table "restaurant_devices", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.bigint "device_id", null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["device_id"], name: "index_restaurant_devices_on_device_id"
    t.index ["restaurant_id"], name: "index_restaurant_devices_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "restaurant_device_histories", "restaurant_devices"
  add_foreign_key "restaurant_device_histories", "restaurants"
  add_foreign_key "restaurant_devices", "devices"
  add_foreign_key "restaurant_devices", "restaurants"
end
