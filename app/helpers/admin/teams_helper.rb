module Admin::TeamsHelper
  def admin_teams_path(*args)
    args.compact!
    args.first.is_a?(Site) ? admin_site_teams_path(*args) : admin_global_teams_path(*args)
  end

  def admin_teams_url(*args)
    args.compact!
    args.first.is_a?(Site) ? admin_site_teams_url(*args) : admin_global_teams_url(*args)
  end

  def admin_team_path(*args)
    args.compact!
    args.first.is_a?(Site) ? admin_site_team_path(*args) : admin_global_team_path(*args)
  end

  def admin_team_url(*args)
    args.compact!
    args.first.is_a?(Site) ? admin_site_team_url(*args) : admin_global_team_url(*args)
  end

  def new_admin_team_path(*args)
    args.compact!
    args.first.is_a?(Site) ? new_admin_site_team_path(*args) : new_admin_global_team_path(*args)
  end

  def edit_admin_team_path(*args)
    args.compact!
    args.first.is_a?(Site) ? edit_admin_site_team_path(*args) : edit_admin_global_team_path(*args)
  end
end
