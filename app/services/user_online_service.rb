class UserOnlineService
  def initialize(user:)
    @user = user
  end

  def perform
    if user_left?
      @user.set_offline
      broadcast_user_info
    elsif @user.offline?
      @user.set_online
      broadcast_user_info
    end
  end

  private

  def user_left?
    @user.online? && disconnected?
  end

  def disconnected?
    PresenceChannel.broadcast_to(@user, action: 'presence-check').to_i.zero?
  end

  def broadcast_user_info
    ActionCable.server.broadcast "users_online_channel", info: { id: @user.id,
                                                                 nickname: @user.nickname,
                                                                 online: @user.online? }
  end
end
