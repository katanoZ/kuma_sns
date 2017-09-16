class AddNotificationTypeToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :notification_type, :string
    add_column :notifications, :follower_id, :integer
  end
end
