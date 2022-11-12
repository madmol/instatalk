class UserOnlineService
  def initialize(user:)
    @user = user
  end

  def perform
    @user.online? ? broadcast_user_online : broadcast_user_offline
  end

  def still_connected?
    still_there = PresenceChannel.broadcast_to(@user, action: 'presence-check')

    return true if still_there.is_a?(Integer) && still_there.positive?

    false
  end

  private

  def broadcast_user_online
    ActionCable.server.broadcast "users_online_channel",
      message: render_message
  end

  def broadcast_user_offline
    ActionCable.server.broadcast "users_online_channel",
      message: { user_offline: @user.nickname }
  end

  def render_message
    ApplicationController.renderer.render(partial: 'users/user_online', locals: {
      user_online: @user
    })
  end

end
