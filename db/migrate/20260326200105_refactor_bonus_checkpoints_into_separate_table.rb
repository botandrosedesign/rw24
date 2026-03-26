class RefactorBonusCheckpointsIntoSeparateTable < ActiveRecord::Migration[8.0]
  def up
    create_table :bonuses, id: :integer do |t|
      t.integer :race_id, null: false
      t.string :name, null: false
      t.integer :points, null: false
      t.string :key, null: false
      t.integer :position, null: false
      t.timestamps
    end

    add_index :bonuses, :key, unique: true
    add_index :bonuses, :race_id

    execute("SELECT id, settings FROM races").each do |race_id, settings_yaml|
      next unless settings_yaml.present?

      settings = YAML.unsafe_load(settings_yaml)
      next unless settings.is_a?(Hash)

      bonuses = settings[:bonuses] || settings["bonuses"] || []
      next if bonuses.empty?

      bonuses.each_with_index do |bonus, index|
        bonus_name = bonus["name"] || bonus[:name]
        bonus_points = (bonus["points"] || bonus[:points]).to_i
        bonus_key = bonus["key"] || bonus[:key] || SecureRandom.hex(8)
        now = Time.now.utc.strftime("%Y-%m-%d %H:%M:%S")

        execute(
          "INSERT INTO bonuses (race_id, name, points, `key`, position, created_at, updated_at) " \
          "VALUES (#{race_id}, #{quote(bonus_name)}, #{bonus_points}, #{quote(bonus_key)}, #{index + 1}, #{quote(now)}, #{quote(now)})"
        )

        new_bonus_id = execute("SELECT LAST_INSERT_ID()").first.first

        execute(
          "UPDATE points SET bonus_id = #{new_bonus_id} " \
          "WHERE race_id = #{race_id} AND category = 'Bonus' AND bonus_id = #{index}"
        )
      end
    end
  end

  def down
    execute("SELECT id, race_id, position FROM bonuses").each do |bonus_id, race_id, position|
      execute(
        "UPDATE points SET bonus_id = #{position - 1} " \
        "WHERE bonus_id = #{bonus_id} AND race_id = #{race_id} AND category = 'Bonus'"
      )
    end

    drop_table :bonuses
  end
end
