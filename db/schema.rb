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

ActiveRecord::Schema[7.1].define(version: 2023_12_07_033639) do
  # These are extensions that must be enabled in order to support this database
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

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_bookmarks_on_product_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fabrics", force: :cascade do |t|
    t.integer "weighted_average_score"
    t.integer "weighted_average_performance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "fibres", force: :cascade do |t|
    t.string "material"
    t.string "material_standard"
    t.string "material_standard_combined"
    t.string "scoring_type"
    t.integer "climate"
    t.integer "water"
    t.integer "chemistry"
    t.integer "land"
    t.integer "biodiversity"
    t.integer "resource_use_and_waste"
    t.integer "human_rights"
    t.integer "animal_welfare"
    t.integer "integrity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_fabrics", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "fabric_id", null: false
    t.integer "fabric_percent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fabric_id"], name: "index_product_fabrics_on_fabric_id"
    t.index ["product_id"], name: "index_product_fabrics_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "item_name"
    t.string "made_in"
    t.string "brand"
    t.bigint "category_id", null: false
    t.string "purchased_in"
    t.string "certification_label"
    t.text "comments"
    t.text "description"
    t.integer "score"
    t.bigint "user_id", null: false
    t.bigint "scan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "brand_logo"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["scan_id"], name: "index_products_on_scan_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "scans", force: :cascade do |t|
    t.string "request_chatgpt"
    t.string "response_chatgpt"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_scans_on_user_id"
  end

  create_table "sdg_fabrics", force: :cascade do |t|
    t.bigint "fabric_id", null: false
    t.bigint "sdg_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fabric_id"], name: "index_sdg_fabrics_on_fabric_id"
    t.index ["sdg_id"], name: "index_sdg_fabrics_on_sdg_id"
  end

  create_table "sdgs", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "score"
    t.integer "impact_performance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wardrobes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_wardrobes_on_product_id"
    t.index ["user_id"], name: "index_wardrobes_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookmarks", "products"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "product_fabrics", "fabrics"
  add_foreign_key "product_fabrics", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "scans"
  add_foreign_key "products", "users"
  add_foreign_key "scans", "users"
  add_foreign_key "sdg_fabrics", "fabrics"
  add_foreign_key "sdg_fabrics", "sdgs"
  add_foreign_key "wardrobes", "products"
  add_foreign_key "wardrobes", "users"
end
