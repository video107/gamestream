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

ActiveRecord::Schema.define(version: 20150714105939) do

  create_table "ahoy_events", force: :cascade do |t|
    t.uuid     "visit_id",   limit: 16
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.text     "properties", limit: 65535
    t.datetime "time"
  end

  add_index "ahoy_events", ["time"], name: "index_ahoy_events_on_time", using: :btree
  add_index "ahoy_events", ["user_id"], name: "index_ahoy_events_on_user_id", using: :btree
  add_index "ahoy_events", ["visit_id"], name: "index_ahoy_events_on_visit_id", using: :btree

  create_table "case_followers", force: :cascade do |t|
    t.integer  "case_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "case_followers", ["case_id"], name: "index_case_followers_on_case_id", using: :btree
  add_index "case_followers", ["user_id"], name: "index_case_followers_on_user_id", using: :btree

  create_table "cases", force: :cascade do |t|
    t.string   "case_url",   limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "menu_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "owner",      limit: 255
  end

  add_index "cases", ["menu_id"], name: "index_cases_on_menu_id", using: :btree
  add_index "cases", ["user_id"], name: "index_cases_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "menu_users", force: :cascade do |t|
    t.integer  "menu_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "menu_users", ["menu_id"], name: "index_menu_users_on_menu_id", using: :btree
  add_index "menu_users", ["user_id"], name: "index_menu_users_on_user_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.text     "contents",                limit: 65535
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "menu_url",                limit: 255
    t.string   "game_pic_file_name",      limit: 255
    t.string   "game_pic_content_type",   limit: 255
    t.integer  "game_pic_file_size",      limit: 4
    t.datetime "game_pic_updated_at"
    t.string   "game_icon_file_name",     limit: 255
    t.string   "game_icon_content_type",  limit: 255
    t.integer  "game_icon_file_size",     limit: 4
    t.datetime "game_icon_updated_at"
    t.string   "menu_url_ios",            limit: 255
    t.string   "game_pic_2_file_name",    limit: 255
    t.string   "game_pic_2_content_type", limit: 255
    t.integer  "game_pic_2_file_size",    limit: 4
    t.datetime "game_pic_2_updated_at"
    t.string   "game_pic_3_file_name",    limit: 255
    t.string   "game_pic_3_content_type", limit: 255
    t.integer  "game_pic_3_file_size",    limit: 4
    t.datetime "game_pic_3_updated_at"
    t.string   "game_pic_4_file_name",    limit: 255
    t.string   "game_pic_4_content_type", limit: 255
    t.integer  "game_pic_4_file_size",    limit: 4
    t.datetime "game_pic_4_updated_at"
    t.string   "game_pic_5_file_name",    limit: 255
    t.string   "game_pic_5_content_type", limit: 255
    t.integer  "game_pic_5_file_size",    limit: 4
    t.datetime "game_pic_5_updated_at"
    t.string   "game_image_file_name",    limit: 255
    t.string   "game_image_content_type", limit: 255
    t.integer  "game_image_file_size",    limit: 4
    t.datetime "game_image_updated_at"
    t.integer  "category_id",             limit: 4
  end

  add_index "menus", ["category_id"], name: "index_menus_on_category_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "provider",               limit: 255
    t.string   "fb_uid",                 limit: 255
    t.string   "name",                   limit: 255
    t.string   "nickname",               limit: 255
    t.string   "phone",                  limit: 255
    t.string   "address",                limit: 255
    t.string   "bank_account",           limit: 255
    t.string   "fb_image",               limit: 255
    t.string   "role",                   limit: 255
    t.string   "bank_name",              limit: 255
    t.integer  "bank_name_code",         limit: 4
    t.string   "google_uid",             limit: 255
    t.string   "uid",                    limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255,   null: false
    t.integer  "item_id",    limit: 4,     null: false
    t.string   "event",      limit: 255,   null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object",     limit: 65535
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "visits", force: :cascade do |t|
    t.uuid     "visitor_id",       limit: 16
    t.string   "ip",               limit: 255
    t.text     "user_agent",       limit: 65535
    t.text     "referrer",         limit: 65535
    t.text     "landing_page",     limit: 65535
    t.integer  "user_id",          limit: 4
    t.string   "referring_domain", limit: 255
    t.string   "search_keyword",   limit: 255
    t.string   "browser",          limit: 255
    t.string   "os",               limit: 255
    t.string   "device_type",      limit: 255
    t.integer  "screen_height",    limit: 4
    t.integer  "screen_width",     limit: 4
    t.string   "country",          limit: 255
    t.string   "region",           limit: 255
    t.string   "city",             limit: 255
    t.string   "postal_code",      limit: 255
    t.decimal  "latitude",                       precision: 10
    t.decimal  "longitude",                      precision: 10
    t.string   "utm_source",       limit: 255
    t.string   "utm_medium",       limit: 255
    t.string   "utm_term",         limit: 255
    t.string   "utm_content",      limit: 255
    t.string   "utm_campaign",     limit: 255
    t.datetime "started_at"
  end

  add_index "visits", ["user_id"], name: "index_visits_on_user_id", using: :btree

end
