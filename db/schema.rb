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

ActiveRecord::Schema.define(version: 20170310080642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "name"
  end

  create_table "authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "token"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_authentications_on_user_id", using: :btree
  end

  create_table "confirmed_activities", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "activity_id"
    t.string   "location"
    t.datetime "datetime"
    t.integer  "duration_in_hours"
    t.boolean  "user1_confirm"
    t.boolean  "user2_confirm"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "match_statuses", force: :cascade do |t|
    t.integer "pending_viewer_id"
    t.integer "pending_viewed_id"
    t.integer "status"
    t.index ["pending_viewer_id", "pending_viewed_id"], name: "index_match_statuses_on_pending_viewer_id_and_pending_viewed_id", unique: true, using: :btree
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.integer  "user1_pending_id"
    t.integer  "user2_pending_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["user1_pending_id", "user2_pending_id"], name: "index_matches_on_user1_pending_id_and_user2_pending_id", unique: true, using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pendings", force: :cascade do |t|
    t.integer  "activity_id"
    t.integer  "user_id"
    t.string   "city"
    t.datetime "datetime"
    t.integer  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                                  null: false
    t.string   "encrypted_password",         limit: 128
    t.string   "confirmation_token",         limit: 128
    t.string   "remember_token",             limit: 128, null: false
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "age_range"
    t.string   "additional_health_problems"
    t.integer  "weekly_activity_hours"
    t.integer  "stamina"
    t.integer  "strength"
    t.integer  "agility"
    t.string   "avatar"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  add_foreign_key "authentications", "users"
end
