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

ActiveRecord::Schema[8.1].define(version: 2026_06_06_163722) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "user_role", ["customer", "employee"]

  create_table "movies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "duration_minutes", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservation_seats", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "reservation_id", null: false
    t.bigint "screening_id", null: false
    t.bigint "seat_id", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_reservation_seats_on_reservation_id"
    t.index ["screening_id", "seat_id"], name: "index_reservation_seats_on_screening_id_and_seat_id", unique: true
    t.index ["screening_id"], name: "index_reservation_seats_on_screening_id"
    t.index ["seat_id"], name: "index_reservation_seats_on_seat_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "screening_id", null: false
    t.string "status", default: "active", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["screening_id"], name: "index_reservations_on_screening_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_rooms_on_name", unique: true
  end

  create_table "screenings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "movie_id", null: false
    t.integer "price", null: false
    t.bigint "room_id", null: false
    t.datetime "starts_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_screenings_on_movie_id"
    t.index ["room_id"], name: "index_screenings_on_room_id"
    t.index ["starts_at", "room_id"], name: "index_screenings_on_starts_at_and_room_id", unique: true
  end

  create_table "seats", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "room_id", null: false
    t.integer "row_no", null: false
    t.integer "seat_no", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id", "row_no", "seat_no"], name: "index_seats_on_room_id_and_row_no_and_seat_no", unique: true
    t.index ["room_id"], name: "index_seats_on_room_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.enum "role", default: "customer", null: false, enum_type: "user_role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "reservation_seats", "reservations"
  add_foreign_key "reservation_seats", "screenings"
  add_foreign_key "reservation_seats", "seats"
  add_foreign_key "reservations", "screenings"
  add_foreign_key "reservations", "users"
  add_foreign_key "screenings", "movies"
  add_foreign_key "screenings", "rooms"
  add_foreign_key "seats", "rooms"
end
