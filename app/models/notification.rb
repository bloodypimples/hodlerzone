class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true

  def get_content
    sender = User.find(self.sender_id)

    notifications = {
      "Friendship": "#{sender.first_name} sent you a friend request."
    }

    notifications[self.notifiable_type.to_sym]
  end
end
