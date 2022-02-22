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

ActiveRecord::Schema.define(version: 2022_02_20_171342) do

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: 6, null: false
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
    t.datetime "created_at", precision: 6, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "dinner_menus", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "menu_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "household_id", null: false
    t.index ["household_id"], name: "index_dinner_menus_on_household_id"
    t.index ["menu_id"], name: "index_dinner_menus_on_menu_id"
    t.index ["recipe_id"], name: "index_dinner_menus_on_recipe_id"
  end

  create_table "households", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.integer "household_id", null: false
    t.integer "user_id"
    t.string "email", null: false
    t.datetime "sent_at"
    t.datetime "accepted_at"
    t.string "token", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_invitations_on_created_by_id"
    t.index ["household_id"], name: "index_invitations_on_household_id"
    t.index ["token"], name: "index_invitations_on_token", unique: true
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "menus", force: :cascade do |t|
    t.datetime "starts_at", precision: 6
    t.datetime "ends_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "household_id", null: false
    t.integer "created_by_id", null: false
    t.integer "edited_by_id", null: false
    t.index ["created_by_id"], name: "index_menus_on_created_by_id"
    t.index ["edited_by_id"], name: "index_menus_on_edited_by_id"
    t.index ["household_id"], name: "index_menus_on_household_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.datetime "last_suggested_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "household_id", null: false
    t.integer "created_by_id", null: false
    t.integer "edited_by_id", null: false
    t.index ["created_by_id"], name: "index_recipes_on_created_by_id"
    t.index ["edited_by_id"], name: "index_recipes_on_edited_by_id"
    t.index ["household_id"], name: "index_recipes_on_household_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest", null: false
    t.string "confirmation_token", null: false
    t.datetime "confirmation_sent_at", precision: 6
    t.datetime "confirmed_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "password_reset_sent_at", precision: 6
    t.string "password_reset_token", null: false
    t.string "unconfirmed_email"
    t.string "remember_token", null: false
    t.string "session_token", null: false
    t.boolean "admin", default: false
    t.integer "household_id", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["household_id"], name: "index_users_on_household_id"
    t.index ["password_reset_token"], name: "index_users_on_password_reset_token", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token", unique: true
    t.index ["session_token"], name: "index_users_on_session_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "dinner_menus", "households"
  add_foreign_key "dinner_menus", "menus"
  add_foreign_key "dinner_menus", "recipes"
  add_foreign_key "invitations", "households"
  add_foreign_key "invitations", "users"
  add_foreign_key "invitations", "users", column: "created_by_id", on_delete: :cascade
  add_foreign_key "menus", "households"
  add_foreign_key "menus", "users", column: "created_by_id", on_delete: :cascade
  add_foreign_key "menus", "users", column: "edited_by_id", on_delete: :cascade
  add_foreign_key "recipes", "households"
  add_foreign_key "recipes", "users", column: "created_by_id", on_delete: :cascade
  add_foreign_key "recipes", "users", column: "edited_by_id", on_delete: :cascade
  add_foreign_key "users", "households"
end
