ActionDispatch::Callbacks.to_prepare do
  Rbac::Context.default_permissions.merge!({
    :'show team'          => [:moderator],
    :'create team'        => [:moderator],
    :'update team'        => [:moderator],
    :'destroy team'       => [:moderator],
    :'manage team'        => [:moderator],
    :'send_confirmation_emails team' => [:moderator],

    :'show rider'          => [:moderator],
    :'create rider'        => [:moderator],
    :'update rider'        => [:moderator],
    :'destroy rider'       => [:moderator],
    :'manage rider'        => [:moderator],
  })
end
