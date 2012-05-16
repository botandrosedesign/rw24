if Rails.plugin?(:adva_rbac)
  ActionDispatch::Callbacks.to_prepare do
    CalendarEvent.acts_as_role_context :parent => :section
  end
end
