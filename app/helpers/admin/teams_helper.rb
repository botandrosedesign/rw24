module Admin
  module TeamsHelper
    BaseHelper.define_shallow_resource_helpers :from => [:admin, :teams], :to => [:admin, :site, :teams] 
  end
end

