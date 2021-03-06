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

ActiveRecord::Schema.define(version: 20160321143651) do

  create_table "case_click_install_excutes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "case_id",    limit: 4
    t.string   "cpc",        limit: 255
    t.string   "cpi",        limit: 255
    t.string   "cpa",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "case_click_install_excutes", ["case_id"], name: "index_case_click_install_excutes_on_case_id", using: :btree
  add_index "case_click_install_excutes", ["user_id"], name: "index_case_click_install_excutes_on_user_id", using: :btree

  create_table "case_excuters", force: :cascade do |t|
    t.integer  "case_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "case_excuters", ["case_id"], name: "index_case_excuters_on_case_id", using: :btree
  add_index "case_excuters", ["user_id"], name: "index_case_excuters_on_user_id", using: :btree

  create_table "case_followers", force: :cascade do |t|
    t.integer  "case_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "case_followers", ["case_id"], name: "index_case_followers_on_case_id", using: :btree
  add_index "case_followers", ["user_id"], name: "index_case_followers_on_user_id", using: :btree

  create_table "case_installers", force: :cascade do |t|
    t.integer  "case_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "case_installers", ["case_id"], name: "index_case_installers_on_case_id", using: :btree
  add_index "case_installers", ["user_id"], name: "index_case_installers_on_user_id", using: :btree

  create_table "cases", force: :cascade do |t|
    t.string   "case_url",    limit: 255
    t.integer  "user_id",     limit: 4
    t.integer  "menu_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "owner",       limit: 255
    t.string   "friendly_id", limit: 255
  end

  add_index "cases", ["friendly_id"], name: "index_cases_on_friendly_id", unique: true, using: :btree
  add_index "cases", ["menu_id"], name: "index_cases_on_menu_id", using: :btree
  add_index "cases", ["user_id"], name: "index_cases_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "channels", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.string   "name",             limit: 255,   null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "url",              limit: 65535
    t.integer  "viewers",          limit: 4
    t.string   "channel_title",    limit: 255
    t.string   "broadcaster_name", limit: 255
  end

  add_index "channels", ["user_id"], name: "index_channels_on_user_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "import_members", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "case_id",    limit: 4
    t.integer  "member_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "menus", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.text     "contents",                limit: 65535
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
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
    t.float    "cpc_android",             limit: 24,    default: 0.0
    t.float    "cpi_android",             limit: 24,    default: 0.0
    t.float    "cpa_android",             limit: 24,    default: 0.0
    t.float    "cpc_ios",                 limit: 24,    default: 0.0
    t.float    "cpi_ios",                 limit: 24,    default: 0.0
    t.float    "cpa_ios",                 limit: 24,    default: 0.0
    t.float    "cpc_android_user",        limit: 24,    default: 0.0
    t.float    "cpi_android_user",        limit: 24,    default: 0.0
    t.float    "cpa_android_user",        limit: 24,    default: 0.0
    t.float    "cpc_ios_user",            limit: 24,    default: 0.0
    t.float    "cpi_ios_user",            limit: 24,    default: 0.0
    t.float    "cpa_ios_user",            limit: 24,    default: 0.0
    t.date     "deadline"
    t.string   "friendly_id",             limit: 255
    t.string   "package_name",            limit: 255
    t.integer  "cpa_period",              limit: 4,     default: 1
    t.float    "cpl_android",             limit: 24,    default: 0.0
    t.float    "cpl_ios",                 limit: 24,    default: 0.0
    t.float    "cpl_android_user",        limit: 24,    default: 0.0
    t.float    "cpl_ios_user",            limit: 24,    default: 0.0
    t.integer  "budget",                  limit: 4,     default: 1000000
    t.string   "game_pic_6_file_name",    limit: 255
    t.string   "game_pic_6_content_type", limit: 255
    t.integer  "game_pic_6_file_size",    limit: 4
    t.datetime "game_pic_6_updated_at"
  end

  add_index "menus", ["category_id"], name: "index_menus_on_category_id", using: :btree
  add_index "menus", ["friendly_id"], name: "index_menus_on_friendly_id", unique: true, using: :btree

  create_table "sdks", force: :cascade do |t|
    t.string   "package_name",         limit: 255
    t.string   "build_id",             limit: 255
    t.string   "device_model",         limit: 255
    t.string   "board",                limit: 255
    t.string   "device",               limit: 255
    t.string   "build_serial",         limit: 255
    t.string   "device_version",       limit: 255
    t.string   "sdk_version",          limit: 255
    t.string   "incremental",          limit: 255
    t.string   "google_account",       limit: 255
    t.string   "imei",                 limit: 255
    t.string   "mac_addr",             limit: 255
    t.string   "google_advertisingid", limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "android_id",           limit: 255
    t.string   "screensize",           limit: 255
    t.string   "imsi",                 limit: 255
    t.integer  "retry",                limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",  null: false
    t.string   "encrypted_password",     limit: 255, default: "",  null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
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
    t.string   "bank_name_code",         limit: 255
    t.string   "google_uid",             limit: 255
    t.string   "uid",                    limit: 255
    t.string   "fans",                   limit: 255
    t.string   "master",                 limit: 255
    t.string   "friendly_id",            limit: 255
    t.string   "twitch_account_url",     limit: 255
    t.string   "youtube_account_url",    limit: 255
    t.string   "bank_branch_name",       limit: 255
    t.string   "profit_money",           limit: 255, default: "0"
    t.string   "total_earn_money",       limit: 255, default: "0"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid", using: :btree
  add_index "users", ["friendly_id"], name: "index_users_on_friendly_id", unique: true, using: :btree
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

  create_table "withdraw_records", force: :cascade do |t|
    t.integer  "amount",                        limit: 4,   default: 0
    t.integer  "user_id",                       limit: 4
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.string   "withdrawaler_name",             limit: 255
    t.string   "withdrawaler_phone",            limit: 255
    t.string   "withdrawaler_bank_name",        limit: 255
    t.string   "withdrawaler_bank_branch_name", limit: 255
    t.string   "withdrawaler_bank_name_code",   limit: 255
    t.string   "withdrawaler_bank_account",     limit: 255
  end

  add_foreign_key "channels", "users"
end
