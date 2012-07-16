module Admin
  module RidersHelper
    BaseHelper.define_shallow_resource_helpers :from => [:admin, :riders], :to => [:admin, :site, :riders] 
  end
end
