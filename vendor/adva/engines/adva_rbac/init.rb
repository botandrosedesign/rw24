$: << lib_path = File.dirname(__FILE__) + '/vendor/rbac/lib'
require 'rbac'

# require 'active_record/acts_as_role_context'
ActiveRecord::Base.send :include, Rbac::ActsAsRoleContext
ActionController::Base.send :include, ActionController::GuardsPermissions

Rbac::RoleType.implementation = Rbac::RoleType::Static
