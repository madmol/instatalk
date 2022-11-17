class HandleOfflineJob < AplicationJob
  queue_as: default

  def perform(user)
    UserOnlineService.new(user: user).perform
  end
end
