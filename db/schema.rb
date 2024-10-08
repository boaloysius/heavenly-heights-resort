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

ActiveRecord::Schema[7.1].define(version: 2024_08_21_060510) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.integer "num_dates", null: false
    t.integer "num_guests", null: false
    t.integer "cabin_price", null: false
    t.integer "extras_price", null: false
    t.integer "total_price", null: false
    t.uuid "cabin_id", null: false
    t.boolean "has_breakfast", null: false
    t.boolean "is_paid", default: false, null: false
    t.text "observations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "status", default: "booked", null: false
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "cabins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "maxCapacity", null: false
    t.integer "regularPrice", null: false
    t.integer "discount"
    t.text "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "imageUrl", null: false
    t.string "imagePublicId", null: false
    t.index ["id"], name: "index_cabins_on_id", unique: true
    t.index ["name"], name: "index_cabins_on_name", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "fullName"
    t.text "nationalID"
    t.text "country"
    t.text "countryFlag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "imageUrl", null: false
    t.string "imagePublicId", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.string "role", default: "client", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.check_constraint "role::text = ANY (ARRAY['admin'::character varying::text, 'client'::character varying::text])", name: "role_constraint"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "cabins"
  add_foreign_key "bookings", "users"
  add_foreign_key "profiles", "users"
end
