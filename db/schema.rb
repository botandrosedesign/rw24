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

ActiveRecord::Schema.define(:version => 20090720132900) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", :force => true do |t|
    t.integer  "site_id"
    t.integer  "section_id"
    t.integer  "author_id"
    t.string   "author_type"
    t.string   "author_name",       :limit => 40
    t.string   "author_email",      :limit => 40
    t.string   "author_homepage"
    t.string   "actions"
    t.integer  "object_id"
    t.string   "object_type",       :limit => 15
    t.text     "object_attributes"
    t.datetime "created_at",                      :null => false
  end

  create_table "cached_page_references", :force => true do |t|
    t.integer "cached_page_id"
    t.integer "object_id"
    t.string  "object_type"
    t.string  "method"
  end

  create_table "cached_pages", :force => true do |t|
    t.integer  "site_id"
    t.integer  "section_id"
    t.string   "url"
    t.datetime "updated_at"
    t.datetime "cleared_at"
  end

  create_table "categories", :force => true do |t|
    t.integer "section_id"
    t.integer "parent_id"
    t.integer "lft",        :default => 0, :null => false
    t.integer "rgt",        :default => 0, :null => false
    t.string  "title"
    t.string  "path"
    t.string  "permalink"
  end

  create_table "categorizations", :force => true do |t|
    t.integer "categorizable_id"
    t.integer "category_id"
    t.string  "categorizable_type"
  end

  create_table "category_translations", :force => true do |t|
    t.integer  "category_id"
    t.string   "locale"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_translations", ["category_id"], :name => "index_category_translations_on_category_id"

  create_table "comments", :force => true do |t|
    t.integer  "site_id"
    t.integer  "section_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "author_id"
    t.string   "author_type"
    t.string   "author_name",      :limit => 40
    t.string   "author_email",     :limit => 40
    t.string   "author_homepage"
    t.text     "body"
    t.text     "body_html"
    t.integer  "approved",                       :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "board_id"
  end

  create_table "content_translations", :force => true do |t|
    t.integer  "content_id"
    t.string   "locale"
    t.integer  "version"
    t.boolean  "current"
    t.string   "title"
    t.text     "excerpt_html"
    t.text     "body_html"
    t.text     "excerpt"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", :force => true do |t|
    t.integer  "site_id"
    t.integer  "section_id"
    t.string   "type",            :limit => 20
    t.integer  "position"
    t.string   "permalink"
    t.text     "excerpt_html"
    t.text     "body_html"
    t.integer  "author_id"
    t.string   "author_type"
    t.string   "author_name",     :limit => 40
    t.string   "author_email",    :limit => 40
    t.string   "author_homepage"
    t.integer  "version"
    t.string   "filter"
    t.integer  "comment_age",                   :default => 0
    t.string   "cached_tag_list"
    t.integer  "assets_count",                  :default => 0
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "counters", :force => true do |t|
    t.integer "owner_id"
    t.string  "owner_type"
    t.string  "name",       :limit => 25
    t.integer "count",                    :default => 0
  end

  create_table "memberships", :force => true do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plugin_configs", :force => true do |t|
    t.string  "name"
    t.text    "options"
    t.integer "owner_id"
    t.string  "owner_type"
  end

  create_table "roles", :force => true do |t|
    t.integer "user_id"
    t.integer "context_id"
    t.string  "context_type"
    t.string  "name",                  :limit => 25
    t.integer "ancestor_context_id"
    t.string  "ancestor_context_type"
  end

  create_table "section_translations", :force => true do |t|
    t.integer  "section_id"
    t.string   "locale"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "section_translations", ["section_id"], :name => "index_section_translations_on_section_id"

  create_table "sections", :force => true do |t|
    t.string   "type"
    t.integer  "site_id"
    t.integer  "parent_id"
    t.integer  "lft",            :default => 0, :null => false
    t.integer  "rgt",            :default => 0, :null => false
    t.string   "path"
    t.string   "permalink"
    t.string   "title"
    t.string   "layout"
    t.string   "template"
    t.text     "options"
    t.integer  "contents_count"
    t.integer  "comment_age"
    t.string   "content_filter"
    t.text     "permissions"
    t.datetime "published_at"
  end

  create_table "sites", :force => true do |t|
    t.string  "name"
    t.string  "host"
    t.string  "title"
    t.string  "subtitle"
    t.string  "email"
    t.string  "timezone"
    t.string  "theme_names"
    t.text    "ping_urls"
    t.string  "akismet_key",        :limit => 100
    t.string  "akismet_url"
    t.boolean "approve_comments"
    t.integer "comment_age"
    t.string  "comment_filter"
    t.string  "search_path"
    t.string  "tag_path"
    t.string  "tag_layout"
    t.string  "permalink_style"
    t.text    "permissions"
    t.boolean "email_notification",                :default => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",       :limit => 40
    t.string   "last_name",        :limit => 40
    t.string   "email",            :limit => 100
    t.string   "homepage"
    t.string   "about"
    t.string   "signature"
    t.string   "password_hash",    :limit => 40
    t.string   "password_salt",    :limit => 40
    t.string   "ip"
    t.string   "agent"
    t.string   "referer"
    t.string   "remember_me",      :limit => 40
    t.string   "token_key",        :limit => 40
    t.datetime "token_expiration"
    t.boolean  "anonymous",                       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "verified_at"
    t.datetime "deleted_at"
    t.integer  "account_id"
  end

  add_index "users", ["account_id"], :name => "index_users_on_account_id"

end
