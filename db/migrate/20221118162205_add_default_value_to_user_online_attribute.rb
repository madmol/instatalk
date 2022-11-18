class AddDefaultValueToUserOnlineAttribute < ActiveRecord::Migration[5.1]
  def change
    def up
      change_column :users, :online, :boolean, null: false, default: false
    end

    def down
      change_column :users, :online, :boolean, null: true, default: nil
    end
  end
end
