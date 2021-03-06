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

ActiveRecord::Schema.define(version: 2021_05_11_175428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "centers", force: :cascade do |t|
    t.integer "center_id"
    t.string "name"
    t.text "address"
    t.string "state_name"
    t.string "district_name"
    t.string "block_name"
    t.integer "pincode"
    t.string "from"
    t.string "to"
    t.integer "lat"
    t.integer "long"
    t.string "fee_type"
    t.string "session_id"
    t.date "date"
    t.string "available_capacity"
    t.decimal "fee"
    t.integer "min_age_limit"
    t.string "vaccine"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "channel"
  end

  create_table "slots", force: :cascade do |t|
    t.string "timing"
    t.bigint "center_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["center_id"], name: "index_slots_on_center_id"
  end

end
