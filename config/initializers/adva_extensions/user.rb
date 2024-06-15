ActiveSupport::Reloader.to_prepare do
  User.class_eval do
    include Authentication::HashHelper

    has_many :riders
    has_many :teams, through: :riders

    attr_writer :unhashed_verification_key

    def generate_verification_key!
      self.unhashed_verification_key = SecureRandom.hex(20)
      update_column :verification_key, hash_string(unhashed_verification_key)
    end

    def unhashed_verification_key
      raise "blank key" if @unhashed_verification_key.blank?
      @unhashed_verification_key
    end

    auto_strip_attributes :first_name, :last_name, :email, :phone

    def team_for race
      if race
        teams.find_by(race: race)
      end
    end
  end
end

