module UsersHelper
  def ban_status(user)
    if user.access_locked?
      'Unlock'
    else
      'Lock'
    end
  end
end