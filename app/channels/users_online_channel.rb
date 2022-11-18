class UsersOnlineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "users_online_channel"
    UserOnlineService.new(user: current_user).perform
  end

  def unsubscribed
    HandleOfflineJob.set(wait: 2.seconds).perform_later(current_user)
  end
end
