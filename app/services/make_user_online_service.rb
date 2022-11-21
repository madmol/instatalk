class MakeUserOnlineService
  def self.call(**args)
    new(user: args[:user]).call
  end

  def initialize(**args)
    @user = args[:user]
  end

  def call
    @user.update(online: true)
    ActionCable.server.broadcast "users_online_channel", user: @user.attributes.slice("id", "nickname", "online")
  end
end
