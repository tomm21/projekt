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

ActiveRecord::Schema.define(version: 20171105144332) do

  create_table "category", primary_key: "category_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 45, null: false
  end

  create_table "movie", primary_key: "movie_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",                 limit: 45, null: false
    t.string  "description",          limit: 45, null: false
    t.string  "director",             limit: 45, null: false
    t.date    "release_date",                    null: false
    t.float   "movie_rating",         limit: 24, null: false, unsigned: true
    t.integer "category_category_id",            null: false
    t.index ["category_category_id"], name: "fk_movie_category1_idx", using: :btree
  end

  create_table "review", primary_key: "review_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "text",           limit: 500, null: false
    t.float   "review_rating",  limit: 24,  null: false
    t.integer "user_user_id",               null: false
    t.integer "movie_movie_id",             null: false
    t.index ["movie_movie_id"], name: "fk_review_movie1_idx", using: :btree
    t.index ["user_user_id"], name: "fk_review_user_idx", using: :btree
  end

  create_table "user", primary_key: "user_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "email",      limit: 45, null: false
    t.string  "password",   limit: 45, null: false
    t.string  "user_name",  limit: 45, null: false
    t.string  "first_name", limit: 45, null: false
    t.string  "last_name",  limit: 45, null: false
    t.integer "admin",      limit: 1,  null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "movie", "category", column: "category_category_id", primary_key: "category_id", name: "fk_movie_category1"
  add_foreign_key "review", "movie", column: "movie_movie_id", primary_key: "movie_id", name: "fk_review_movie1"
  add_foreign_key "review", "user", column: "user_user_id", primary_key: "user_id", name: "fk_review_user"
end
