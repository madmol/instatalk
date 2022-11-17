class UsersOnlineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "users_online_channel"
    UserOnlineService.new(user: current_user).perform
  end

  def unsubscribed
    HandleOfflineJob.perform_at(5.seconds.from_now, current_user)
  end
end
