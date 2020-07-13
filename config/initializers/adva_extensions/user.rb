ActiveSupport::Reloader.to_prepare do
  User.class_eval do
    has_many :riders
    has_many :teams, through: :riders
  end
end

