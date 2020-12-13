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

ActiveRecord::Schema.define(version: 2020_12_12_190344) do

  create_table "cars", force: :cascade do |t|
    t.integer "driver_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["driver_id"], name: "index_cars_on_driver_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "total_space", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "preferences", force: :cascade do |t|
    t.string "preferrer_type"
    t.integer "preferrer_id"
    t.string "preferable_type"
    t.integer "preferable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["preferable_type", "preferable_id"], name: "index_preferences_on_preferable"
    t.index ["preferrer_type", "preferrer_id"], name: "index_preferences_on_preferrer"
  end

  create_table "riders", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "car_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_riders_on_car_id"
  end

  add_foreign_key "cars", "drivers"
  add_foreign_key "riders", "cars"
end
