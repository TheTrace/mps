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

ActiveRecord::Schema.define(version: 20140903084119) do

  create_table "contacts", force: true do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "phone"
    t.string   "email"
    t.text     "address"
    t.string   "post_code"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "solicitor",  default: false
    t.boolean  "mediator",   default: false
    t.boolean  "client",     default: false
    t.integer  "upload_id"
  end

  create_table "jobs", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reference"
    t.integer  "party_a_id"
    t.integer  "party_b_id"
    t.integer  "legal_rep"
    t.integer  "mediator"
    t.decimal  "fees_paid",       precision: 9, scale: 2
    t.date     "mediation_date"
    t.integer  "legal_rep1"
    t.integer  "legal_rep2"
    t.integer  "legal_rep3"
    t.integer  "mediator1"
    t.integer  "mediator2"
    t.integer  "mediator3"
    t.string   "colour",                                  default: "428BCA"
    t.time     "mediation_time"
    t.integer  "observer1"
    t.integer  "observer2"
    t.integer  "observer3"
    t.datetime "start_date"
    t.string   "status",                                  default: "enquiry"
    t.integer  "user_id"
    t.datetime "enquiry_date"
    t.datetime "completion_date"
  end

  create_table "links", force: true do |t|
    t.integer  "job_id"
    t.integer  "contact_id"
    t.string   "contact_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", force: true do |t|
    t.string   "detail"
    t.string   "type_str"
    t.integer  "note_id"
    t.integer  "task_id"
    t.integer  "contact_id"
    t.integer  "job_id"
    t.integer  "template_task_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "job_id"
    t.string   "note_type"
    t.decimal  "cost",       precision: 9, scale: 2
    t.decimal  "time_taken", precision: 9, scale: 2
    t.boolean  "paid",                               default: false
    t.datetime "the_date"
    t.decimal  "mileage",    precision: 9, scale: 2
    t.integer  "user_id"
  end

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "job_id"
    t.datetime "party_a_complete_date"
    t.datetime "party_b_complete_date"
    t.datetime "complete_date"
    t.datetime "tentative_due_date"
    t.datetime "due_date"
    t.integer  "sort_order"
    t.decimal  "cost",                  precision: 9, scale: 2
    t.boolean  "is_financial",                                  default: false
    t.boolean  "paid",                                          default: false
    t.integer  "template_task_id"
    t.integer  "user_id"
    t.boolean  "two",                                           default: true
  end

  create_table "template_tasks", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "due_days"
    t.integer  "hard_due_days"
    t.integer  "sort_order"
    t.boolean  "is_financial",  default: false
    t.boolean  "two",           default: true
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.integer  "level",           default: 0
    t.boolean  "active",          default: true, null: false
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
