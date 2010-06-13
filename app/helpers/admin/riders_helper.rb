module Admin::RidersHelper
  def admin_riders_path(*args)
    args.compact!
    args.first.is_a?(Site) ? admin_site_riders_path(*args) : admin_global_riders_path(*args)
  end

  def admin_riders_url(*args)
    args.compact!
    args.first.is_a?(Site) ? admin_site_riders_url(*args) : admin_global_riders_url(*args)
  end

  def admin_rider_path(*args)
    args.compact!
    args.first.is_a?(Site) ? admin_site_rider_path(*args) : admin_global_rider_path(*args)
  end

  def admin_rider_url(*args)
    args.compact!
    args.first.is_a?(Site) ? admin_site_rider_url(*args) : admin_global_rider_url(*args)
  end

  def new_admin_rider_path(*args)
    args.compact!
    args.first.is_a?(Site) ? new_admin_site_rider_path(*args) : new_admin_global_rider_path(*args)
  end

  def edit_admin_rider_path(*args)
    args.compact!
    args.first.is_a?(Site) ? edit_admin_site_rider_path(*args) : edit_admin_global_rider_path(*args)
  end
end
