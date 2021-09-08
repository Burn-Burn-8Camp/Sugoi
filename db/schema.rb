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

ActiveRecord::Schema.define(version: 2021_09_07_104303) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addressbooks", force: :cascade do |t|
    t.string "receiver"
    t.string "tel"
    t.string "address"
    t.string "area_code"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_addressbooks_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.string "name"
    t.string "price"
    t.string "quantity"
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "serial"
    t.string "receiver"
    t.string "tel"
    t.string "address"
    t.string "email"
    t.string "delivery"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.integer "quantity"
    t.string "category"
    t.string "material"
    t.string "manufacturing_method"
    t.string "country"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.string "picture"
    t.string "account"
    t.string "rank"
    t.integer "accumulated_amount", default: 0
    t.string "country"
    t.string "name"
    t.integer "p_coins", default: 0
    t.string "gender"
    t.date "birthday"
    t.string "self_about"
    t.string "self_blog"
    t.string "self_web"
    t.string "life_shopping"
    t.string "life_design"
    t.string "image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["rank"], name: "index_users_on_rank"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addressbooks", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "users"
end
