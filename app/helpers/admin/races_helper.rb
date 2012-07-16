module Admin
  module RacesHelper  
    BaseHelper.define_shallow_resource_helpers :from => [:admin, :races], :to => [:admin, :site, :races] 
  end
end

