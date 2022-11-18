class AddDefaultValueToUserOnlineAttribute < ActiveRecord::Migration[5.1]
  def change
    reversible do |direction|
      direction.up {
        User.where(online: nil).update_all(online: false)
      }
    end
    change_column :users, :online, :boolean, null: false, default: false
  end
end
