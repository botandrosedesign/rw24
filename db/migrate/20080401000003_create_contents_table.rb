class CreateContentsTable < ActiveRecord::Migration
  def change
    create_table :contents, :force => true do |t|
      t.references :site
      t.references :section
      t.string     :type, :limit => 20
      t.integer    :position

      t.string     :permalink
      t.text       :excerpt_html
      t.text       :body_html

      t.references :author, :polymorphic => true
      t.string     :author_name, :limit => 40
      t.string     :author_email, :limit => 40
      t.string     :author_homepage

      t.integer    :version
      t.string     :filter
      t.integer    :comment_age, :default => 0
      t.string     :cached_tag_list
      t.integer    :assets_count, :default => 0

      t.datetime   :published_at
      t.datetime   :created_at
      t.datetime   :updated_at
    end

    create_table "content_translations" do |t|
      t.integer  "content_id"
      t.string   "locale"
      t.integer  "version"
      t.boolean  "current"
      t.text     "excerpt"
      t.text     "excerpt_html"
      t.string   "title"
      t.text     "body"
      t.text     "body_html"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
