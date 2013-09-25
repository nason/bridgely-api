# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130921053056) do

  create_table "v1_activities", force: true do |t|
    t.integer "employee_id"
    t.integer "message_id"
    t.integer "question_id"
    t.string  "message_sid", default: "pending", null: false
    t.string  "sms_status",  default: "pending", null: false
  end

  add_index "v1_activities", ["employee_id"], name: "index_v1_activities_on_employee_id"
  add_index "v1_activities", ["message_id"], name: "index_v1_activities_on_message_id"
  add_index "v1_activities", ["message_sid"], name: "index_v1_activities_on_message_sid"
  add_index "v1_activities", ["question_id"], name: "index_v1_activities_on_question_id"

  create_table "v1_admin_companies", force: true do |t|
    t.string   "name",                    null: false
    t.text     "settings",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_sid"
  end

  add_index "v1_admin_companies", ["account_sid"], name: "index_v1_admin_companies_on_account_sid"
  add_index "v1_admin_companies", ["name"], name: "index_v1_admin_companies_on_name"

  create_table "v1_admin_users", force: true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.boolean  "admin",               default: false
    t.string   "email"
    t.string   "encrypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sign_in_count",       default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authorization_token"
  end

  add_index "v1_admin_users", ["authorization_token"], name: "index_v1_admin_users_on_authorization_token", unique: true
  add_index "v1_admin_users", ["company_id"], name: "index_v1_admin_users_on_company_id"
  add_index "v1_admin_users", ["email"], name: "index_v1_admin_users_on_email"

  create_table "v1_employees", force: true do |t|
    t.integer  "company_id", null: false
    t.string   "phone",      null: false
    t.string   "name",       null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "v1_employees", ["company_id"], name: "index_v1_employees_on_company_id"
  add_index "v1_employees", ["name"], name: "index_v1_employees_on_name"
  add_index "v1_employees", ["phone"], name: "index_v1_employees_on_phone"

  create_table "v1_messages", force: true do |t|
    t.integer  "company_id",                       null: false
    t.integer  "question_id"
    t.string   "body",                             null: false
    t.string   "direction",   default: "outbound", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "v1_messages", ["company_id"], name: "index_v1_messages_on_company_id"
  add_index "v1_messages", ["question_id"], name: "index_v1_messages_on_question_id"

  create_table "v1_questions", force: true do |t|
    t.string   "title",        null: false
    t.string   "response_tag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "message_id"
  end

  add_index "v1_questions", ["message_id"], name: "index_v1_questions_on_message_id"
  add_index "v1_questions", ["response_tag"], name: "index_v1_questions_on_response_tag"

end
