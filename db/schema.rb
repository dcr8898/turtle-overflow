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

ActiveRecord::Schema.define(version: 20151024140614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text     "body",                    null: false
    t.integer  "user_id",                 null: false
    t.integer  "question_id",             null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "votes_count", default: 0
  end

  add_index "answers", ["created_at"], name: "index_answers_on_created_at", using: :btree
  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["updated_at"], name: "index_answers_on_updated_at", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body",                         null: false
    t.integer  "user_id",                      null: false
    t.integer  "commentable_id",               null: false
    t.string   "commentable_type",             null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "votes_count",      default: 0
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  add_index "comments", ["created_at"], name: "index_comments_on_created_at", using: :btree
  add_index "comments", ["updated_at"], name: "index_comments_on_updated_at", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "title",                   null: false
    t.text     "body",                    null: false
    t.integer  "user_id",                 null: false
    t.integer  "answer_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "votes_count", default: 0
  end

  add_index "questions", ["answer_id"], name: "index_questions_on_answer_id", using: :btree
  add_index "questions", ["created_at"], name: "index_questions_on_created_at", using: :btree
  add_index "questions", ["updated_at"], name: "index_questions_on_updated_at", using: :btree
  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "questions_tags", force: :cascade do |t|
    t.integer  "question_id", null: false
    t.integer  "tag_id",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "questions_tags", ["created_at"], name: "index_questions_tags_on_created_at", using: :btree
  add_index "questions_tags", ["question_id"], name: "index_questions_tags_on_question_id", using: :btree
  add_index "questions_tags", ["tag_id"], name: "index_questions_tags_on_tag_id", using: :btree
  add_index "questions_tags", ["updated_at"], name: "index_questions_tags_on_updated_at", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "text",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["created_at"], name: "index_tags_on_created_at", using: :btree
  add_index "tags", ["text"], name: "index_tags_on_text", using: :btree
  add_index "tags", ["updated_at"], name: "index_tags_on_updated_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["created_at"], name: "index_users_on_created_at", using: :btree
  add_index "users", ["updated_at"], name: "index_users_on_updated_at", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "value",         null: false
    t.integer  "user_id",       null: false
    t.integer  "voteable_id",   null: false
    t.string   "voteable_type", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "votes", ["created_at"], name: "index_votes_on_created_at", using: :btree
  add_index "votes", ["updated_at"], name: "index_votes_on_updated_at", using: :btree
  add_index "votes", ["user_id", "voteable_id", "voteable_type"], name: "index_votes_on_user_id_and_voteable_id_and_voteable_type", unique: true, using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree
  add_index "votes", ["voteable_type", "voteable_id"], name: "index_votes_on_voteable_type_and_voteable_id", using: :btree

end
