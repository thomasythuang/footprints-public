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

ActiveRecord::Schema.define(version: 20180711192755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annual_starting_craftsman_salaries", force: true do |t|
    t.string "location", null: false
    t.float  "amount",   null: false
  end

  add_index "annual_starting_craftsman_salaries", ["location"], name: "location_uniquness", unique: true, using: :btree

  create_table "applicants", force: true do |t|
    t.string   "name"
    t.date     "applied_on"
    t.string   "email"
    t.date     "initial_reply_on"
    t.date     "completed_challenge_on"
    t.date     "reviewed_on"
    t.date     "begin_refactoring_on"
    t.date     "resubmitted_challenge_on"
    t.date     "decision_made_on"
    t.string   "hired",                    default: "no_decision"
    t.string   "codeschool"
    t.string   "college_degree"
    t.string   "cs_degree"
    t.string   "worked_as_dev"
    t.string   "assigned_craftsman"
    t.string   "code_submission"
    t.text     "additional_notes"
    t.integer  "craftsman_id"
    t.text     "about"
    t.text     "software_interest"
    t.text     "reason"
    t.text     "url"
    t.string   "slug"
    t.boolean  "has_steward"
    t.string   "skill"
    t.string   "discipline"
    t.string   "location"
    t.boolean  "archived",                 default: false
    t.date     "start_date"
    t.date     "end_date"
    t.date     "sent_challenge_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "offered_on"
    t.string   "mentor"
  end

  add_index "applicants", ["craftsman_id"], name: "index_applicants_on_craftsman_id", using: :btree
  add_index "applicants", ["name"], name: "index_applicants_on_name", using: :btree
  add_index "applicants", ["slug"], name: "index_applicants_on_slug", unique: true, using: :btree

  create_table "assigned_craftsman_records", force: true do |t|
    t.integer  "applicant_id"
    t.integer  "craftsman_id"
    t.boolean  "current",      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenges", force: true do |t|
    t.integer "user_id",        null: false
    t.integer "target_user_id", null: false
    t.boolean "challenged",     null: false
  end

  create_table "chat_messages", force: true do |t|
    t.integer  "sender_id",    null: false
    t.integer  "recipient_id", null: false
    t.string   "message",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "craftsmen", force: true do |t|
    t.string  "name"
    t.string  "status"
    t.integer "employment_id"
    t.string  "uid"
    t.string  "email"
    t.string  "location",          default: "Chicago"
    t.boolean "archived",          default: false
    t.string  "position"
    t.boolean "seeking",           default: false
    t.integer "skill",             default: 1,         null: false
    t.boolean "has_apprentice",    default: false,     null: false
    t.date    "unavailable_until"
  end

  add_index "craftsmen", ["employment_id"], name: "employment_id_uniqueness", unique: true, using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "matches", force: true do |t|
    t.integer  "fighter_1_id", null: false
    t.integer  "fighter_2_id", null: false
    t.integer  "winner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "applicant_id"
    t.text     "body"
    t.datetime "created_at"
    t.string   "title"
    t.datetime "updated_at"
  end

  add_index "messages", ["applicant_id"], name: "index_messages_on_applicant_id", using: :btree

  create_table "monthly_apprentice_salaries", force: true do |t|
    t.integer "duration", null: false
    t.string  "location", null: false
    t.float   "amount",   null: false
  end

  add_index "monthly_apprentice_salaries", ["duration", "location"], name: "duration_location_uniquness", unique: true, using: :btree

  create_table "notes", force: true do |t|
    t.text     "body"
    t.integer  "craftsman_id"
    t.integer  "applicant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer  "applicant_id"
    t.integer  "craftsman_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.string  "name",  null: false
    t.boolean "value", null: false
  end

  create_table "users", force: true do |t|
    t.string   "login"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                  null: false
    t.string   "uid"
    t.string   "provider"
    t.integer  "craftsman_id"
    t.boolean  "employee"
    t.boolean  "admin",                  default: false, null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.text     "description"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
