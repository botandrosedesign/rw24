module Activities
  def self.included(base)
    base.has_many :activities, :dependent => :destroy
  end
end

ActionDispatch::Callbacks.to_prepare do
  Site.send :include, Activities
end
