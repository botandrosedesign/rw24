ActionDispatch::Callbacks.to_prepare do
  BaseController.renders_in_context :section
end
