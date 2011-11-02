# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111102210426) do

  create_table "cars", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cars", ["user_id"], :name => "index_cars_on_user_id"

  create_table "refuels", :force => true do |t|
    t.integer  "car_id"
    t.datetime "refueled_at"
    t.integer  "odometer"
    t.float    "gallons"
    t.float    "mpg"
    t.integer  "distance"
    t.integer  "price_cents", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refuels", ["car_id", "refueled_at"], :name => "index_refuels_on_car_id_and_refueled_at", :unique => true
  add_index "refuels", ["car_id"], :name => "index_refuels_on_car_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
