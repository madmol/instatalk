class HandleOfflineJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    if PresenceChannel.broadcast_to(user, action: "presence-check").to_i.zero?
      user.update(online: false)
      ActionCable.server.broadcast "users_online_channel", user: user.attributes.slice("id", "nickname", "online")
    end
  end
end
