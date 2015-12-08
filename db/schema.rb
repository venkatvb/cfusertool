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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20151208120744) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "accounts", ["email"], :name => "index_accounts_on_email", :unique => true
  add_index "accounts", ["remember_token"], :name => "index_accounts_on_remember_token"

  create_table "friends", :force => true do |t|
    t.string   "handle"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "friends", ["account_id"], :name => "index_friends_on_account_id"

  create_table "spoj_handles", :force => true do |t|
    t.string   "name"
    t.string   "handle"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "solved"
    t.text     "todo"
  end

  create_table "spoj_problem_to_tags", :force => true do |t|
    t.integer  "problemId"
    t.integer  "tagId"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "spoj_problem_to_users", :force => true do |t|
    t.integer  "problemId"
    t.integer  "userId"
    t.boolean  "solved"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "spoj_problems", :force => true do |t|
    t.string   "setter"
    t.integer  "conceptualDifficulty"
    t.integer  "implementationDifficulty"
    t.integer  "upvote"
    t.integer  "downvote"
    t.integer  "usersAccepted"
    t.integer  "submissions"
    t.integer  "accepted"
    t.integer  "wrongAnswer"
    t.integer  "compilationError"
    t.integer  "runtimeError"
    t.integer  "timeLimitExceeded"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "code"
  end

  add_index "spoj_problems", ["code"], :name => "index_spoj_problems_on_code", :unique => true

  create_table "spoj_tag_to_problems", :force => true do |t|
    t.integer  "tagId"
    t.integer  "problemId"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "spoj_tags", :force => true do |t|
    t.string   "tagName"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "spoj_user_to_problems", :force => true do |t|
    t.integer  "userId"
    t.integer  "problemId"
    t.boolean  "solved"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "todos", :force => true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "done"
    t.string   "tags"
  end

  add_index "todos", ["account_id"], :name => "index_todos_on_account_id"

end
