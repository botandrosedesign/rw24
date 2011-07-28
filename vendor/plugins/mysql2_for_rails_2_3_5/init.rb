# based on https://github.com/brianmario/mysql2/commit/90ddb63e52cd48c1a1b

module ActiveRecord::ConnectionAdapters
  begin
    ActiveRecord::ConnectionAdapters::Mysql2Adapter # triggers some autoloading

    Mysql2IndexDefinition = Struct.new(:table, :name, :unique, :columns, :lengths) unless defined? Mysql2IndexDefinition

    Mysql2Adapter.class_eval do
      def indexes(table_name, name = nil)
        indexes = []
        current_index = nil
        result = execute("SHOW KEYS FROM #{quote_table_name(table_name)}", name)
        result.each(:symbolize_keys => true, :as => :hash) do |row|
          if current_index != row[:Key_name]
            next if row[:Key_name] == Mysql2Adapter::PRIMARY # skip the primary key
            current_index = row[:Key_name]
            indexes << Mysql2IndexDefinition.new(row[:Table], row[:Key_name], row[:Non_unique] == 0, [], [])
          end

          indexes.last.columns << row[:Column_name]
          indexes.last.lengths << row[:Sub_part]
        end
        indexes
      end
    end
  rescue NameError
    # nothing to patch, looks like some other adapter is used
  end
end
