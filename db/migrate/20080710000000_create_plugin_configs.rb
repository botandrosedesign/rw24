class CreatePluginConfigs < ActiveRecord::Migration[4.2]
  def self.up
    create_table :plugin_configs, :force => true do |t|
      t.references :site
      t.string     :name
      t.text       :options
    end
  end

  def self.down
    drop_table :plugin_configs
  end
end
