class String
  def methodize
    self.parameterize.underscore.to_s
  end
end
