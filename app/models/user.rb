class User < ApplicationRecord
  before_create :generate_nickname

  def generate_nickname
    self.nickname = Faker::Name.first_name.downcase
  end

  def set_offline
    update(online: false)
  end

  def set_online
    update(online: true)
  end

  def offline?
    !online?
  end
end
