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

ActiveRecord::Schema.define(version: 2019_06_11_063454) do

  create_table "accounts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "site_id"
    t.integer "section_id"
    t.integer "author_id"
    t.string "author_type"
    t.string "author_name", limit: 40
    t.string "author_email", limit: 40
    t.string "author_homepage"
    t.string "actions"
    t.integer "object_id"
    t.string "object_type", limit: 15
    t.text "object_attributes"
    t.datetime "created_at", null: false
    t.index ["author_id"], name: "index_activities_on_author_id"
    t.index ["object_id"], name: "index_activities_on_object_id"
    t.index ["section_id"], name: "index_activities_on_section_id"
    t.index ["site_id"], name: "index_activities_on_site_id"
  end

  create_table "cached_page_references", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "cached_page_id"
    t.integer "object_id"
    t.string "object_type"
    t.string "method"
    t.index ["cached_page_id"], name: "index_cached_page_references_on_cached_page_id"
    t.index ["object_id"], name: "index_cached_page_references_on_object_id"
  end

  create_table "cached_pages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "site_id"
    t.integer "section_id"
    t.string "url"
    t.datetime "updated_at"
    t.datetime "cleared_at"
    t.index ["section_id"], name: "index_cached_pages_on_section_id"
    t.index ["site_id"], name: "index_cached_pages_on_site_id"
  end

  create_table "categories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "section_id"
    t.integer "parent_id"
    t.integer "lft", default: 0, null: false
    t.integer "rgt", default: 0, null: false
    t.string "title"
    t.string "path"
    t.string "permalink"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
    t.index ["section_id"], name: "index_categories_on_section_id"
  end

  create_table "categorizations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "categorizable_id"
    t.integer "category_id"
    t.string "categorizable_type"
    t.index ["categorizable_id"], name: "index_categorizations_on_categorizable_id"
    t.index ["category_id"], name: "index_categorizations_on_category_id"
  end

  create_table "category_translations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "category_id"
    t.string "locale"
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id"], name: "index_category_translations_on_category_id"
  end

  create_table "comments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "site_id"
    t.integer "section_id"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.integer "author_id"
    t.string "author_type"
    t.string "author_name", limit: 40
    t.string "author_email", limit: 40
    t.string "author_homepage"
    t.text "body"
    t.text "body_html"
    t.integer "approved", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "board_id"
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["board_id"], name: "index_comments_on_board_id"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["section_id"], name: "index_comments_on_section_id"
    t.index ["site_id"], name: "index_comments_on_site_id"
  end

  create_table "content_translations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "content_id"
    t.string "locale"
    t.integer "version"
    t.boolean "current"
    t.string "title"
    t.text "excerpt_html"
    t.text "body_html"
    t.text "excerpt"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["content_id"], name: "index_content_translations_on_content_id"
  end

  create_table "contents", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "site_id"
    t.integer "section_id"
    t.string "type", limit: 20
    t.string "permalink"
    t.text "excerpt_html"
    t.text "body_html"
    t.integer "author_id"
    t.string "author_type"
    t.string "author_name", limit: 40
    t.string "author_email", limit: 40
    t.string "author_homepage"
    t.integer "version"
    t.string "filter"
    t.integer "comment_age", default: 0
    t.string "cached_tag_list"
    t.integer "assets_count", default: 0
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "parent_id"
    t.integer "lft", default: 0, null: false
    t.integer "rgt", default: 0, null: false
    t.string "meta_author"
    t.string "meta_geourl"
    t.string "meta_copyright"
    t.string "meta_keywords"
    t.text "meta_description"
    t.string "title"
    t.text "body"
    t.text "excerpt"
    t.index ["author_id"], name: "index_contents_on_author_id"
    t.index ["parent_id"], name: "index_contents_on_parent_id"
    t.index ["section_id"], name: "index_contents_on_section_id"
    t.index ["site_id"], name: "index_contents_on_site_id"
  end

  create_table "counters", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "owner_id"
    t.string "owner_type"
    t.string "name", limit: 25
    t.integer "count", default: 0
    t.index ["owner_id"], name: "index_counters_on_owner_id"
  end

  create_table "delayed_jobs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "priority", default: 0
    t.integer "attempts", default: 0
    t.text "handler"
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "memberships", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "site_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["site_id"], name: "index_memberships_on_site_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "plugin_configs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.text "options"
    t.integer "owner_id"
    t.string "owner_type"
    t.index ["owner_id"], name: "index_plugin_configs_on_owner_id"
  end

  create_table "points", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "team_id"
    t.integer "qty"
    t.string "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "race_id"
    t.integer "bonus_id"
    t.index ["race_id"], name: "index_points_on_race_id"
    t.index ["team_id"], name: "index_points_on_team_id"
  end

  create_table "races", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "year"
    t.datetime "start_time"
    t.text "description"
    t.boolean "published"
    t.text "settings"
  end

  create_table "riders", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "team_id"
    t.string "name"
    t.string "email"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "shirt"
    t.boolean "paid", default: false
    t.string "payment_type"
    t.date "confirmed_on"
    t.text "notes"
    t.string "phone"
    t.index ["team_id"], name: "index_riders_on_team_id"
  end

  create_table "roles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "context_id"
    t.string "context_type"
    t.string "name", limit: 25
    t.integer "ancestor_context_id"
    t.string "ancestor_context_type"
    t.index ["ancestor_context_id"], name: "index_roles_on_ancestor_context_id"
    t.index ["context_id"], name: "index_roles_on_context_id"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "section_translations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "section_id"
    t.string "locale"
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["section_id"], name: "index_section_translations_on_section_id"
  end

  create_table "sections", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "type"
    t.integer "site_id"
    t.integer "parent_id"
    t.integer "lft", default: 0, null: false
    t.integer "rgt", default: 0, null: false
    t.string "path"
    t.string "permalink"
    t.string "title"
    t.string "layout"
    t.string "template"
    t.text "options"
    t.integer "contents_count"
    t.integer "comment_age"
    t.string "content_filter"
    t.text "permissions"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "hidden_on_global_nav", default: false
    t.index ["parent_id"], name: "index_sections_on_parent_id"
    t.index ["site_id"], name: "index_sections_on_site_id"
  end

  create_table "sites", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "host"
    t.string "title"
    t.string "subtitle"
    t.string "email"
    t.string "timezone"
    t.string "theme_names"
    t.text "ping_urls"
    t.string "akismet_key", limit: 100
    t.string "akismet_url"
    t.boolean "approve_comments"
    t.integer "comment_age"
    t.string "comment_filter"
    t.string "search_path"
    t.string "tag_path"
    t.string "tag_layout"
    t.string "permalink_style"
    t.text "permissions"
    t.boolean "email_notification", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "meta_author"
    t.string "meta_geourl"
    t.string "meta_copyright"
    t.string "meta_keywords"
    t.text "meta_description"
    t.text "confirmation_email_body"
  end

  create_table "taggings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.datetime "created_at"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type"], name: "index_taggings_on_taggable_id_and_taggable_type"
  end

  create_table "tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
  end

  create_table "team_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "min", null: false
    t.integer "max", null: false
    t.string "initial"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "legacy_category"
    t.string "address"
    t.string "line_2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.integer "site_id"
    t.integer "position"
    t.integer "race_id"
    t.datetime "confirmation_sent_at"
    t.text "shirt_sizes"
    t.integer "category_id"
    t.index ["race_id"], name: "index_teams_on_race_id"
    t.index ["site_id"], name: "index_teams_on_site_id"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "first_name", limit: 40
    t.string "last_name", limit: 40
    t.string "email", limit: 100
    t.string "homepage"
    t.string "about"
    t.string "signature"
    t.string "password_hash", limit: 40
    t.string "password_salt", limit: 40
    t.string "ip"
    t.string "agent"
    t.string "referer"
    t.string "remember_me", limit: 40
    t.string "token_key", limit: 40
    t.datetime "token_expiration"
    t.boolean "anonymous", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "verified_at"
    t.datetime "deleted_at"
    t.integer "account_id"
    t.index ["account_id"], name: "index_users_on_account_id"
  end

end
