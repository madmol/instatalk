class HandleOfflineJob < ApplicationJob
  queue_as :default

  def perform(user)
    @user = user

    if disconnected?
      UserOnlineService.new(user: @user).perform(set_offline_status = true)
    end
  end

  private

  def disconnected?
    @user.online? && PresenceChannel.broadcast_to(@user, action: "presence-check").to_i.zero?
  end
end
