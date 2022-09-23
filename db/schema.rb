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

ActiveRecord::Schema[7.0].define(version: 2022_09_19_063642) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "name_kana"
    t.string "zip_code"
    t.string "address_city"
    t.string "address_street"
    t.string "address_building"
    t.string "president"
    t.integer "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string "prefecture_code"
    t.string "city_code"
    t.string "name"
    t.text "occupation"
    t.text "payment"
    t.text "location"
    t.text "working_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shift_table_cols", force: :cascade do |t|
    t.bigint "shift_table_id"
    t.date "work_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shift_table_id"], name: "index_shift_table_cols_on_shift_table_id"
  end

  create_table "shift_tables", force: :cascade do |t|
    t.bigint "job_id"
    t.date "work_start_on"
    t.date "work_end_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_shift_tables_on_job_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.bigint "shift_table_col_id"
    t.integer "recruiting_number", default: 0, null: false
    t.integer "applicant_number", default: 0, null: false
    t.boolean "recruited", default: false, null: false
    t.datetime "work_start_at"
    t.datetime "work_end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shift_table_col_id"], name: "index_shifts_on_shift_table_col_id"
  end

  add_foreign_key "shift_table_cols", "shift_tables"
  add_foreign_key "shift_tables", "jobs"
  add_foreign_key "shifts", "shift_table_cols"
end
