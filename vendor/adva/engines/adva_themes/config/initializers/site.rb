ActionDispatch::Callbacks.to_prepare do
  Site.has_many_themes
end
