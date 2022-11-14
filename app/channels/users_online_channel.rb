class UsersOnlineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "users_online_channel"
    unless current_user.online?
      current_user.update(online: true)
      speak
    end
  end

  def unsubscribed
    sleep 5
    unless UserOnlineService.new(user: current_user).still_connected?
      current_user.update(online: false)
      speak
    end
  end

  def speak(**data)
    UserOnlineService.new(user: current_user).perform
  end
end
