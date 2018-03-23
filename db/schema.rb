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

ActiveRecord::Schema.define(version: 20180323015704) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", force: :cascade do |t|
    t.integer  "site_id",           limit: 4
    t.integer  "section_id",        limit: 4
    t.integer  "author_id",         limit: 4
    t.string   "author_type",       limit: 255
    t.string   "author_name",       limit: 40
    t.string   "author_email",      limit: 40
    t.string   "author_homepage",   limit: 255
    t.string   "actions",           limit: 255
    t.integer  "object_id",         limit: 4
    t.string   "object_type",       limit: 15
    t.text     "object_attributes", limit: 65535
    t.datetime "created_at",                      null: false
  end

  add_index "activities", ["author_id"], name: "index_activities_on_author_id", using: :btree
  add_index "activities", ["object_id"], name: "index_activities_on_object_id", using: :btree
  add_index "activities", ["section_id"], name: "index_activities_on_section_id", using: :btree
  add_index "activities", ["site_id"], name: "index_activities_on_site_id", using: :btree

  create_table "cached_page_references", force: :cascade do |t|
    t.integer "cached_page_id", limit: 4
    t.integer "object_id",      limit: 4
    t.string  "object_type",    limit: 255
    t.string  "method",         limit: 255
  end

  add_index "cached_page_references", ["cached_page_id"], name: "index_cached_page_references_on_cached_page_id", using: :btree
  add_index "cached_page_references", ["object_id"], name: "index_cached_page_references_on_object_id", using: :btree

  create_table "cached_pages", force: :cascade do |t|
    t.integer  "site_id",    limit: 4
    t.integer  "section_id", limit: 4
    t.string   "url",        limit: 255
    t.datetime "updated_at"
    t.datetime "cleared_at"
  end

  add_index "cached_pages", ["section_id"], name: "index_cached_pages_on_section_id", using: :btree
  add_index "cached_pages", ["site_id"], name: "index_cached_pages_on_site_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.integer "section_id", limit: 4
    t.integer "parent_id",  limit: 4
    t.integer "lft",        limit: 4,   default: 0, null: false
    t.integer "rgt",        limit: 4,   default: 0, null: false
    t.string  "title",      limit: 255
    t.string  "path",       limit: 255
    t.string  "permalink",  limit: 255
  end

  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree
  add_index "categories", ["section_id"], name: "index_categories_on_section_id", using: :btree

  create_table "categorizations", force: :cascade do |t|
    t.integer "categorizable_id",   limit: 4
    t.integer "category_id",        limit: 4
    t.string  "categorizable_type", limit: 255
  end

  add_index "categorizations", ["categorizable_id"], name: "index_categorizations_on_categorizable_id", using: :btree
  add_index "categorizations", ["category_id"], name: "index_categorizations_on_category_id", using: :btree

  create_table "category_translations", force: :cascade do |t|
    t.integer  "category_id", limit: 4
    t.string   "locale",      limit: 255
    t.string   "title",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_translations", ["category_id"], name: "index_category_translations_on_category_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "site_id",          limit: 4
    t.integer  "section_id",       limit: 4
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "author_id",        limit: 4
    t.string   "author_type",      limit: 255
    t.string   "author_name",      limit: 40
    t.string   "author_email",     limit: 40
    t.string   "author_homepage",  limit: 255
    t.text     "body",             limit: 65535
    t.text     "body_html",        limit: 65535
    t.integer  "approved",         limit: 4,     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "board_id",         limit: 4
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["board_id"], name: "index_comments_on_board_id", using: :btree
  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["section_id"], name: "index_comments_on_section_id", using: :btree
  add_index "comments", ["site_id"], name: "index_comments_on_site_id", using: :btree

  create_table "content_translations", force: :cascade do |t|
    t.integer  "content_id",   limit: 4
    t.string   "locale",       limit: 255
    t.integer  "version",      limit: 4
    t.boolean  "current"
    t.string   "title",        limit: 255
    t.text     "excerpt_html", limit: 65535
    t.text     "body_html",    limit: 65535
    t.text     "excerpt",      limit: 65535
    t.text     "body",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_translations", ["content_id"], name: "index_content_translations_on_content_id", using: :btree

  create_table "contents", force: :cascade do |t|
    t.integer  "site_id",          limit: 4
    t.integer  "section_id",       limit: 4
    t.string   "type",             limit: 20
    t.string   "permalink",        limit: 255
    t.text     "excerpt_html",     limit: 65535
    t.text     "body_html",        limit: 65535
    t.integer  "author_id",        limit: 4
    t.string   "author_type",      limit: 255
    t.string   "author_name",      limit: 40
    t.string   "author_email",     limit: 40
    t.string   "author_homepage",  limit: 255
    t.integer  "version",          limit: 4
    t.string   "filter",           limit: 255
    t.integer  "comment_age",      limit: 4,     default: 0
    t.string   "cached_tag_list",  limit: 255
    t.integer  "assets_count",     limit: 4,     default: 0
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id",        limit: 4
    t.integer  "lft",              limit: 4,     default: 0, null: false
    t.integer  "rgt",              limit: 4,     default: 0, null: false
    t.string   "meta_author",      limit: 255
    t.string   "meta_geourl",      limit: 255
    t.string   "meta_copyright",   limit: 255
    t.string   "meta_keywords",    limit: 255
    t.text     "meta_description", limit: 65535
    t.string   "title",            limit: 255
    t.text     "body",             limit: 65535
    t.text     "excerpt",          limit: 65535
  end

  add_index "contents", ["author_id"], name: "index_contents_on_author_id", using: :btree
  add_index "contents", ["parent_id"], name: "index_contents_on_parent_id", using: :btree
  add_index "contents", ["section_id"], name: "index_contents_on_section_id", using: :btree
  add_index "contents", ["site_id"], name: "index_contents_on_site_id", using: :btree

  create_table "counters", force: :cascade do |t|
    t.integer "owner_id",   limit: 4
    t.string  "owner_type", limit: 255
    t.string  "name",       limit: 25
    t.integer "count",      limit: 4,   default: 0
  end

  add_index "counters", ["owner_id"], name: "index_counters_on_owner_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0
    t.integer  "attempts",   limit: 4,     default: 0
    t.text     "handler",    limit: 65535
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "site_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["site_id"], name: "index_memberships_on_site_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "plugin_configs", force: :cascade do |t|
    t.string  "name",       limit: 255
    t.text    "options",    limit: 65535
    t.integer "owner_id",   limit: 4
    t.string  "owner_type", limit: 255
  end

  add_index "plugin_configs", ["owner_id"], name: "index_plugin_configs_on_owner_id", using: :btree

  create_table "points", force: :cascade do |t|
    t.integer  "team_id",    limit: 4
    t.integer  "qty",        limit: 4
    t.string   "category",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "race_id",    limit: 4
    t.integer  "bonus_id",   limit: 4
  end

  add_index "points", ["race_id"], name: "index_points_on_race_id", using: :btree
  add_index "points", ["team_id"], name: "index_points_on_team_id", using: :btree

  create_table "races", force: :cascade do |t|
    t.integer  "year",        limit: 4
    t.datetime "start_time"
    t.text     "description", limit: 65535
    t.boolean  "published"
    t.text     "settings",    limit: 65535
  end

  create_table "riders", force: :cascade do |t|
    t.integer  "team_id",      limit: 4
    t.string   "name",         limit: 255
    t.string   "email",        limit: 255
    t.integer  "position",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shirt",        limit: 255
    t.boolean  "paid",                       default: false
    t.string   "payment_type", limit: 255
    t.date     "confirmed_on"
    t.text     "notes",        limit: 65535
    t.string   "phone",        limit: 255
  end

  add_index "riders", ["team_id"], name: "index_riders_on_team_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer "user_id",               limit: 4
    t.integer "context_id",            limit: 4
    t.string  "context_type",          limit: 255
    t.string  "name",                  limit: 25
    t.integer "ancestor_context_id",   limit: 4
    t.string  "ancestor_context_type", limit: 255
  end

  add_index "roles", ["ancestor_context_id"], name: "index_roles_on_ancestor_context_id", using: :btree
  add_index "roles", ["context_id"], name: "index_roles_on_context_id", using: :btree
  add_index "roles", ["user_id"], name: "index_roles_on_user_id", using: :btree

  create_table "section_translations", force: :cascade do |t|
    t.integer  "section_id", limit: 4
    t.string   "locale",     limit: 255
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "section_translations", ["section_id"], name: "index_section_translations_on_section_id", using: :btree

  create_table "sections", force: :cascade do |t|
    t.string   "type",                 limit: 255
    t.integer  "site_id",              limit: 4
    t.integer  "parent_id",            limit: 4
    t.integer  "lft",                  limit: 4,     default: 0,     null: false
    t.integer  "rgt",                  limit: 4,     default: 0,     null: false
    t.string   "path",                 limit: 255
    t.string   "permalink",            limit: 255
    t.string   "title",                limit: 255
    t.string   "layout",               limit: 255
    t.string   "template",             limit: 255
    t.text     "options",              limit: 65535
    t.integer  "contents_count",       limit: 4
    t.integer  "comment_age",          limit: 4
    t.string   "content_filter",       limit: 255
    t.text     "permissions",          limit: 65535
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden_on_global_nav",               default: false
  end

  add_index "sections", ["parent_id"], name: "index_sections_on_parent_id", using: :btree
  add_index "sections", ["site_id"], name: "index_sections_on_site_id", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.string   "host",                    limit: 255
    t.string   "title",                   limit: 255
    t.string   "subtitle",                limit: 255
    t.string   "email",                   limit: 255
    t.string   "timezone",                limit: 255
    t.string   "theme_names",             limit: 255
    t.text     "ping_urls",               limit: 65535
    t.string   "akismet_key",             limit: 100
    t.string   "akismet_url",             limit: 255
    t.boolean  "approve_comments"
    t.integer  "comment_age",             limit: 4
    t.string   "comment_filter",          limit: 255
    t.string   "search_path",             limit: 255
    t.string   "tag_path",                limit: 255
    t.string   "tag_layout",              limit: 255
    t.string   "permalink_style",         limit: 255
    t.text     "permissions",             limit: 65535
    t.boolean  "email_notification",                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "meta_author",             limit: 255
    t.string   "meta_geourl",             limit: 255
    t.string   "meta_copyright",          limit: 255
    t.string   "meta_keywords",           limit: 255
    t.text     "meta_description",        limit: 65535
    t.text     "confirmation_email_body", limit: 65535
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type"], name: "index_taggings_on_taggable_id_and_taggable_type", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.string   "category",             limit: 255
    t.string   "address",              limit: 255
    t.string   "line_2",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city",                 limit: 255
    t.string   "state",                limit: 255
    t.string   "zip",                  limit: 255
    t.integer  "site_id",              limit: 4
    t.integer  "position",             limit: 4
    t.integer  "race_id",              limit: 4
    t.datetime "confirmation_sent_at"
    t.text     "shirt_sizes",          limit: 65535
  end

  add_index "teams", ["race_id"], name: "index_teams_on_race_id", using: :btree
  add_index "teams", ["site_id"], name: "index_teams_on_site_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",       limit: 40
    t.string   "last_name",        limit: 40
    t.string   "email",            limit: 100
    t.string   "homepage",         limit: 255
    t.string   "about",            limit: 255
    t.string   "signature",        limit: 255
    t.string   "password_hash",    limit: 40
    t.string   "password_salt",    limit: 40
    t.string   "ip",               limit: 255
    t.string   "agent",            limit: 255
    t.string   "referer",          limit: 255
    t.string   "remember_me",      limit: 40
    t.string   "token_key",        limit: 40
    t.datetime "token_expiration"
    t.boolean  "anonymous",                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "verified_at"
    t.datetime "deleted_at"
    t.integer  "account_id",       limit: 4
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree

end
