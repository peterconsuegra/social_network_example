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

ActiveRecord::Schema.define(version: 2021_11_03_202825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
  end

  create_table "friends", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "target_id"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_friends_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "body"
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "twitter_account_id", null: false
    t.text "body"
    t.datetime "publish_at"
    t.string "tweet_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["twitter_account_id"], name: "index_tweets_on_twitter_account_id"
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "twitter_accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "username"
    t.string "image"
    t.string "token"
    t.string "secret"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_twitter_accounts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.text "bio"
    t.text "likes"
    t.text "dislikes"
    t.date "birth"
    t.string "web"
    t.string "name"
    t.string "last_name"
    t.integer "profile_pic_id"
  end

  add_foreign_key "tweets", "twitter_accounts"
  add_foreign_key "tweets", "users"
  add_foreign_key "twitter_accounts", "users"
end
