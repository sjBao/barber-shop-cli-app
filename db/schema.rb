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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_07_04_155725) do

  create_table "appointments", force: :cascade do |t|
    t.integer "barber_id"
    t.integer "client_id"
    t.string "notes"
    t.datetime "time_slot"
    t.index ["barber_id"], name: "index_appointments_on_barber_id"
    t.index ["client_id"], name: "index_appointments_on_client_id"
  end

  create_table "barbers", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_barbers_on_name", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.index ["email"], name: "index_clients_on_email", unique: true
  end

end
