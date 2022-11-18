class UserOnlineService
  def initialize(user:)
    @user = user
  end

  def perform(set_offline_status = false)
    return if @user.online? && !set_offline_status

    if @user.offline?
      @user.set_online
    else
      @user.set_offline
    end

    broadcast_user_info
  end

  private

  def broadcast_user_info
    ActionCable.server.broadcast "users_online_channel", info: { id: @user.id,
                                                                 nickname: @user.nickname,
                                                                 online: @user.online? }
  end
end
