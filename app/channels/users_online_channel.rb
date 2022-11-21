class UsersOnlineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "users_online_channel"
    MakeUserOnlineService.(user: current_user) unless current_user.online?
  end

  def unsubscribed
    MakeUserOfflineService.(user: current_user)
  end
end
