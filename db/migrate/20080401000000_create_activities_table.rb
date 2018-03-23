class CreateActivitiesTable < ActiveRecord::Migration[4.2]
  def self.up
    create_table :activities, :force => true do |t|
      t.references :site
      t.references :section

      t.references :author, :polymorphic => true
      t.string     :author_name, :limit => 40
      t.string     :author_email, :limit => 40
      t.string     :author_homepage

      t.string     :actions
      t.integer    :object_id
      t.string     :object_type, :limit => 15
      t.text       :object_attributes
      t.datetime   :created_at, :null => false
    end

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
  end

  def self.down
    drop_table :activities
  end
end
