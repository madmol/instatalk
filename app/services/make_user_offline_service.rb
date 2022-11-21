class MakeUserOfflineService
  def self.call(**args)
    new(user: args[:user]).call
  end

  def initialize(**args)
    @user = args[:user]
  end

  def call
    HandleOfflineJob.set(wait: 5.seconds).perform_later(@user.id)
  end
end
