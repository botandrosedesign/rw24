class PreparesUpdatesUserEmailAddress
  class Error < StandardError; end

  class EmailAlreadyTaken < Error
    def message
      "There is already an user with this email address!"
    end
  end

  class EmailInvalidFormat < Error
    def message
      "Email address does not appear to be valid!"
    end
  end

  def self.execute user, new_email, host_with_port
    raise EmailAlreadyTaken if User.find_by_email(new_email)
    raise EmailInvalidFormat if ValidatesEmailFormatOf.validate_email_format(new_email)

    user.update new_email: new_email
    user.generate_verification_key!
    Mailer.change_email(user, user.unhashed_verification_key, host_with_port).deliver_now
  end
end
