# This migration comes from adva_engine (originally 20260408000001)
class UpgradeTaggableTablesForActsAsTaggableOn < ActiveRecord::Migration[7.0]
  def up
    change_table :tags do |t|
      t.integer :taggings_count, default: 0 unless column_exists?(:tags, :taggings_count)
      unless column_exists?(:tags, :created_at)
        t.datetime :created_at
        t.datetime :updated_at
      end
    end
    execute "UPDATE tags SET created_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP WHERE created_at IS NULL"
    change_column_null :tags, :created_at, false
    change_column_null :tags, :updated_at, false
    add_index :tags, :name, unique: true unless index_exists?(:tags, :name)

    change_table :taggings do |t|
      t.string :context, limit: 128 unless column_exists?(:taggings, :context)
      t.references :tagger, polymorphic: true unless column_exists?(:taggings, :tagger_id)
      t.string :tenant, limit: 128 unless column_exists?(:taggings, :tenant)
    end

    execute "UPDATE taggings SET context = 'tags' WHERE context IS NULL"

    unless index_exists?(:taggings, [:taggable_id, :taggable_type, :context])
      add_index :taggings, [:taggable_id, :taggable_type, :context]
    end
    unless index_exists?(:taggings, [:tag_id, :taggable_id, :taggable_type, :context, :tagger_id, :tagger_type], name: "taggings_idx")
      add_index :taggings, [:tag_id, :taggable_id, :taggable_type, :context, :tagger_id, :tagger_type],
        unique: true, name: "taggings_idx"
    end
    unless index_exists?(:taggings, :tenant)
      add_index :taggings, :tenant
    end

    ActsAsTaggableOn::Tag.reset_column_information
    ActsAsTaggableOn::Tag.find_each do |tag|
      ActsAsTaggableOn::Tag.reset_counters(tag.id, :taggings)
    end
  end

  def down
    remove_index :taggings, name: "taggings_idx", if_exists: true
    remove_index :taggings, [:taggable_id, :taggable_type, :context], if_exists: true
    remove_index :taggings, :tenant, if_exists: true

    remove_column :taggings, :context if column_exists?(:taggings, :context)
    remove_column :taggings, :tagger_id if column_exists?(:taggings, :tagger_id)
    remove_column :taggings, :tagger_type if column_exists?(:taggings, :tagger_type)
    remove_column :taggings, :tenant if column_exists?(:taggings, :tenant)

    remove_column :tags, :taggings_count if column_exists?(:tags, :taggings_count)
    remove_column :tags, :created_at if column_exists?(:tags, :created_at)
    remove_column :tags, :updated_at if column_exists?(:tags, :updated_at)
    remove_index :tags, :name, if_exists: true
  end
end
