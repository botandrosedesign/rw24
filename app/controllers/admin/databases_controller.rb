class Admin::DatabasesController < Admin::BaseController
  def show
    Backhoe.dump({
      file_path: temp_path,
      skip_tables: [
        :accounts,
        :activities,
        :comments,
        :users,
      ],
      skip_columns: {
        contents: [
          :author_email,
        ],
        riders: [
          :email,
          :payment_type,
          :notes,
        ],
        teams: [
          :address,
          :line_2,
        ],
      }
    })
    send_file temp_path,
      filename: filename,
      type: "application/sql"
  end

  private

  def temp_path
    @temp_path ||= Tempfile.new("database").path
  end

  def filename
    date = Time.zone.today.to_s.underscore
    "rw24-database-#{date}.sql"
  end
end

