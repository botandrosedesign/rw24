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

<<<<<<< HEAD
ActiveRecord::Schema.define(:version => 20120504051059) do
=======
ActiveRecord::Schema.define(:version => 20120508012551) do
>>>>>>> 35f9973... HOLY SHIT

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

  add_index "activities", ["author_id"], :name => "index_activities_on_author_id"
  add_index "activities", ["object_id"], :name => "index_activities_on_object_id"
  add_index "activities", ["section_id"], :name => "index_activities_on_section_id"
  add_index "activities", ["site_id"], :name => "index_activities_on_site_id"

  create_table "cached_page_references", :force => true do |t|
    t.integer "cached_page_id"
    t.integer "object_id"
    t.string  "object_type"
    t.string  "method"
  end

  add_index "cached_page_references", ["cached_page_id"], :name => "index_cached_page_references_on_cached_page_id"
  add_index "cached_page_references", ["object_id"], :name => "index_cached_page_references_on_object_id"

  create_table "cached_pages", :force => true do |t|
    t.integer  "site_id"
    t.integer  "section_id"
    t.string   "url"
    t.datetime "updated_at"
    t.datetime "cleared_at"
  end

  add_index "cached_pages", ["section_id"], :name => "index_cached_pages_on_section_id"
  add_index "cached_pages", ["site_id"], :name => "index_cached_pages_on_site_id"

  create_table "categories", :force => true do |t|
    t.integer "section_id"
    t.integer "parent_id"
    t.integer "lft",        :default => 0, :null => false
    t.integer "rgt",        :default => 0, :null => false
    t.string  "title"
    t.string  "path"
    t.string  "permalink"
  end

  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"
  add_index "categories", ["section_id"], :name => "index_categories_on_section_id"

  create_table "categorizations", :force => true do |t|
    t.integer "categorizable_id"
    t.integer "category_id"
    t.string  "categorizable_type"
  end

  add_index "categorizations", ["categorizable_id"], :name => "index_categorizations_on_categorizable_id"
  add_index "categorizations", ["category_id"], :name => "index_categorizations_on_category_id"

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

  add_index "comments", ["author_id"], :name => "index_comments_on_author_id"
  add_index "comments", ["board_id"], :name => "index_comments_on_board_id"
  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["section_id"], :name => "index_comments_on_section_id"
  add_index "comments", ["site_id"], :name => "index_comments_on_site_id"

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

  add_index "content_translations", ["content_id"], :name => "index_content_translations_on_content_id"

  create_table "contents", :force => true do |t|
    t.integer  "site_id"
    t.integer  "section_id"
    t.string   "type",            :limit => 20
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
    t.integer  "parent_id"
    t.integer  "lft",                           :default => 0, :null => false
    t.integer  "rgt",                           :default => 0, :null => false
  end

  add_index "contents", ["author_id"], :name => "index_contents_on_author_id"
  add_index "contents", ["parent_id"], :name => "index_contents_on_parent_id"
  add_index "contents", ["section_id"], :name => "index_contents_on_section_id"
  add_index "contents", ["site_id"], :name => "index_contents_on_site_id"

  create_table "counters", :force => true do |t|
    t.integer "owner_id"
    t.string  "owner_type"
    t.string  "name",       :limit => 25
    t.integer "count",                    :default => 0
  end

  add_index "counters", ["owner_id"], :name => "index_counters_on_owner_id"

<<<<<<< HEAD
=======
  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", :force => true do |t|
    t.string   "green_certification"
    t.integer  "stories"
    t.string   "school_middle"
    t.string   "construction"
    t.string   "internet_address_yn"
    t.string   "utilities"
    t.text     "fireplace_description"
    t.string   "area"
    t.string   "lot_size"
    t.integer  "garage_or_parking_spaces"
    t.string   "property_category"
    t.string   "accessibility_features"
    t.string   "present_use"
    t.string   "street_dir_suffix"
    t.string   "photo_date_time_modified"
    t.string   "street_number"
    t.string   "property_type"
    t.string   "roof_type"
    t.string   "street_type_suffix"
    t.string   "energy_efficiency_features"
    t.string   "lot_description"
    t.string   "price_type"
    t.string   "hot_water_description"
    t.string   "rets_status"
    t.integer  "fireplaces_total"
    t.string   "listing_id"
    t.integer  "beds"
    t.decimal  "latitude",                        :precision => 10, :scale => 7
    t.string   "zoning"
    t.string   "year_built_description"
    t.string   "fencing"
    t.string   "living_room_features"
    t.string   "green_certification_yn"
    t.string   "green_certification_year"
    t.string   "waterfront_description"
    t.string   "date_time_modified"
    t.string   "road_frontage"
    t.string   "parking_description"
    t.string   "unit_number"
    t.integer  "photos_count"
    t.string   "school_elementary"
    t.text     "kitchen_appliances"
    t.string   "disable_comments_yn"
    t.decimal  "baths_total",                     :precision => 3,  :scale => 1
    t.string   "video_tour_yn"
    t.string   "street_dir_prefix"
    t.string   "list_office_name"
    t.string   "tax_amount"
    t.text     "interior_features"
    t.string   "cooling_description"
    t.string   "sewer_description"
    t.integer  "price_list"
    t.string   "list_office_phone"
    t.string   "dining_room_features"
    t.decimal  "longitude",                       :precision => 10, :scale => 7
    t.string   "street_name"
    t.string   "street_number_display"
    t.string   "list_agent_phone"
    t.string   "water_name"
    t.string   "baths_full"
    t.string   "road_frontage_yn"
    t.integer  "levels"
    t.string   "fuel_description"
    t.string   "baths_partial"
    t.string   "short_sale_yn"
    t.string   "listing_status"
    t.string   "water_front_yn"
    t.string   "disable_avmyn"
    t.string   "exterior_features"
    t.string   "topography"
    t.integer  "number_of_lots_total"
    t.string   "garage_type"
    t.string   "list_office_id"
    t.string   "zip_code"
    t.string   "virtual_tour_yn"
    t.string   "view"
    t.string   "full_street_address"
    t.string   "heating_description"
    t.string   "view_yn"
    t.string   "accessibility_yn"
    t.string   "existing_structures_description"
    t.string   "exterior_description"
    t.string   "family_room_features"
    t.string   "state"
    t.string   "subdivision"
    t.string   "internet_yn"
    t.string   "master_bedroom_level"
    t.string   "city"
    t.decimal  "acres",                           :precision => 6,  :scale => 2
    t.string   "school_high"
    t.string   "list_agent_id"
    t.integer  "price_maximum"
    t.string   "road_surface"
    t.integer  "price_minimum"
    t.integer  "sq_ft_approximate_total"
    t.string   "virtual_tour_url"
    t.string   "lot_size_dimension"
    t.integer  "sq_ft_approximate_gross"
    t.string   "list_agent_phone_extension"
    t.string   "list_agent_full_name"
    t.string   "video_tour_url"
    t.string   "county"
    t.string   "bank_owned_yn"
    t.string   "water_description"
    t.string   "basement_foundation"
    t.string   "style"
    t.text     "remarks_public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sqft"
    t.integer  "unit_type1_beds_total"
    t.decimal  "unit_type1_baths_total",          :precision => 3,  :scale => 1
    t.string   "unit_type1_features"
    t.integer  "unit_type1_sq_ft"
    t.integer  "unit_type2_beds_total"
    t.decimal  "unit_type2_baths_total",          :precision => 3,  :scale => 1
    t.string   "unit_type2_features"
    t.integer  "unit_type2_sq_ft"
    t.integer  "unit_type3_beds_total"
    t.decimal  "unit_type3_baths_total",          :precision => 3,  :scale => 1
    t.string   "unit_type3_features"
    t.integer  "unit_type3_sq_ft"
    t.integer  "unit_type4_beds_total"
    t.decimal  "unit_type4_baths_total",          :precision => 3,  :scale => 1
    t.string   "unit_type4_features"
    t.integer  "unit_type4_sq_ft"
    t.integer  "unit_type5_beds_total"
    t.decimal  "unit_type5_baths_total",          :precision => 3,  :scale => 1
    t.string   "unit_type5_features"
    t.integer  "unit_type5_sq_ft"
    t.integer  "unit_type6_beds_total"
    t.decimal  "unit_type6_baths_total",          :precision => 3,  :scale => 1
    t.string   "unit_type6_features"
    t.integer  "unit_type6_sq_ft"
    t.integer  "unit_type7_beds_total"
    t.decimal  "unit_type7_baths_total",          :precision => 3,  :scale => 1
    t.string   "unit_type7_features"
    t.integer  "unit_type7_sq_ft"
    t.integer  "unit_type8_beds_total"
    t.decimal  "unit_type8_baths_total",          :precision => 3,  :scale => 1
    t.string   "unit_type8_features"
    t.integer  "unit_type8_sq_ft"
    t.integer  "unit_type9_beds_total"
    t.decimal  "unit_type9_baths_total",          :precision => 3,  :scale => 1
    t.string   "unit_type9_features"
    t.integer  "unit_type9_sq_ft"
    t.integer  "unit_type10_beds_total"
    t.decimal  "unit_type10_baths_total",         :precision => 3,  :scale => 1
    t.string   "unit_type10_features"
    t.integer  "unit_type10_sq_ft"
    t.string   "short_sale_offer_yn"
    t.string   "permalink"
    t.text     "photos_array"
    t.string   "neighborhood_name"
    t.integer  "number_of_units_total"
    t.integer  "year_built"
  end

  add_index "listings", ["latitude"], :name => "index_listings_on_latitude"
  add_index "listings", ["list_agent_id"], :name => "index_listings_on_list_agent_id"
  add_index "listings", ["list_office_id"], :name => "index_listings_on_list_office_id"
  add_index "listings", ["listing_id"], :name => "index_listings_on_listing_id"
  add_index "listings", ["longitude"], :name => "index_listings_on_longitude"
  add_index "listings", ["neighborhood_name"], :name => "index_listings_on_neighborhood_name"

>>>>>>> 35f9973... HOLY SHIT
  create_table "memberships", :force => true do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["site_id"], :name => "index_memberships_on_site_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "plugin_configs", :force => true do |t|
    t.string  "name"
    t.text    "options"
    t.integer "owner_id"
    t.string  "owner_type"
  end

  add_index "plugin_configs", ["owner_id"], :name => "index_plugin_configs_on_owner_id"

  create_table "points", :force => true do |t|
    t.integer  "team_id"
    t.integer  "qty"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "race_id"
  end

  add_index "points", ["race_id"], :name => "index_points_on_race_id"
  add_index "points", ["team_id"], :name => "index_points_on_team_id"

  create_table "races", :force => true do |t|
    t.integer  "year"
    t.datetime "start_time"
    t.text     "description"
    t.boolean  "published"
  end

  create_table "riders", :force => true do |t|
    t.integer  "team_id"
    t.string   "name"
    t.string   "email"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shirt"
    t.boolean  "paid",         :default => false
    t.string   "payment_type"
    t.date     "confirmed_on"
    t.text     "notes"
    t.string   "phone"
  end

  add_index "riders", ["team_id"], :name => "index_riders_on_team_id"

  create_table "roles", :force => true do |t|
    t.integer "user_id"
    t.integer "context_id"
    t.string  "context_type"
    t.string  "name",                  :limit => 25
    t.integer "ancestor_context_id"
    t.string  "ancestor_context_type"
  end

  add_index "roles", ["ancestor_context_id"], :name => "index_roles_on_ancestor_context_id"
  add_index "roles", ["context_id"], :name => "index_roles_on_context_id"
  add_index "roles", ["user_id"], :name => "index_roles_on_user_id"

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

  add_index "sections", ["parent_id"], :name => "index_sections_on_parent_id"
  add_index "sections", ["site_id"], :name => "index_sections_on_site_id"

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

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.string   "address"
    t.string   "line_2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "site_id"
    t.integer  "position"
    t.integer  "race_id"
  end

  add_index "teams", ["race_id"], :name => "index_teams_on_race_id"
  add_index "teams", ["site_id"], :name => "index_teams_on_site_id"

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
