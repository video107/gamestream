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

ActiveRecord::Schema.define(version: 20150626084838) do

  create_table "cases", force: :cascade do |t|
    t.string   "case_url",   limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "menu_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "cases", ["menu_id"], name: "index_cases_on_menu_id", using: :btree
  add_index "cases", ["user_id"], name: "index_cases_on_user_id", using: :btree

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
  end

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
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
