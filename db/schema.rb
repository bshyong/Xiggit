# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100520081922) do

  create_table "book_posts", :force => true do |t|
    t.string   "isbn"
    t.string   "title"
    t.string   "author"
    t.string   "publisher"
    t.string   "ed"
    t.integer  "year"
    t.float    "price"
    t.string   "course"
    t.string   "condition"
    t.text     "comments"
    t.integer  "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "school_name"
  end

  add_index "book_posts", ["condition"], :name => "condition_ix"
  add_index "book_posts", ["course"], :name => "course_ix"
  add_index "book_posts", ["created_at"], :name => "created_at_ix"
  add_index "book_posts", ["id"], :name => "bp_id_ix"
  add_index "book_posts", ["isbn"], :name => "isbn_ix"
  add_index "book_posts", ["price"], :name => "price_ix"
  add_index "book_posts", ["school_name"], :name => "school_name_ix"
  add_index "book_posts", ["uid"], :name => "uid_ix"

  create_table "courses", :force => true do |t|
    t.integer  "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "checked"
  end

  add_index "courses", ["uid"], :name => "course_uid_ix"

  create_table "facebook_templates", :force => true do |t|
    t.string "template_name", :null => false
    t.string "content_hash",  :null => false
    t.string "bundle_id"
  end

  add_index "facebook_templates", ["template_name"], :name => "index_facebook_templates_on_template_name", :unique => true

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "facebook_id",          :limit => 20
    t.string   "facebook_session_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "school_name"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "new"
  end

  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id"

end
