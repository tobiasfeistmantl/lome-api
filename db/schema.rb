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

ActiveRecord::Schema.define(version: 20161012092628) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "likes", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id", "user_id"], name: "index_likes_on_post_id_and_user_id", unique: true, using: :btree
    t.index ["post_id"], name: "index_likes_on_post_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "post_abuse_reports", force: :cascade do |t|
    t.integer  "reporter_id"
    t.integer  "post_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["post_id"], name: "index_post_abuse_reports_on_post_id", using: :btree
    t.index ["reporter_id"], name: "index_post_abuse_reports_on_reporter_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.text     "message"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "author_id"
    t.string   "image"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "status",      default: 0, null: false
    t.integer  "likes_count", default: 0
    t.index ["author_id"], name: "index_posts_on_author_id", using: :btree
    t.index ["latitude"], name: "index_posts_on_latitude", using: :btree
    t.index ["longitude"], name: "index_posts_on_longitude", using: :btree
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
    t.index ["follower_id"], name: "index_relationships_on_follower_id", using: :btree
  end

  create_table "user_positions", force: :cascade do |t|
    t.integer  "user_session_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["latitude"], name: "index_user_positions_on_latitude", using: :btree
    t.index ["longitude"], name: "index_user_positions_on_longitude", using: :btree
    t.index ["user_session_id"], name: "index_user_positions_on_user_session_id", using: :btree
  end

  create_table "user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_sessions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "profile_image"
    t.integer  "follower_count",    default: 0
    t.integer  "followed_count",    default: 0
    t.integer  "role",              default: 0,     null: false
    t.boolean  "posting_privilege", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "post_abuse_reports", "posts"
  add_foreign_key "post_abuse_reports", "users", column: "reporter_id"
  add_foreign_key "posts", "users", column: "author_id"
  add_foreign_key "relationships", "users", column: "followed_id"
  add_foreign_key "relationships", "users", column: "follower_id"
  add_foreign_key "user_positions", "user_sessions"
  add_foreign_key "user_sessions", "users"
end
