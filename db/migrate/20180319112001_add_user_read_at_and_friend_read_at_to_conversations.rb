class AddUserReadAtAndFriendReadAtToConversations < ActiveRecord::Migration[5.1]
  def change
    add_column :conversations, :user_read_at, :datetime
    add_column :conversations, :friend_read_at, :datetime
  end
end
