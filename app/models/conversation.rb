class Conversation < ApplicationRecord
  has_many :messages
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def get_correspondant(current_user)
    if current_user == self.user
      self.friend
    else
      self.user
    end
  end

  def user_has_permission?(user)
    if user.get_all_conversations.include?(self)
      true
    else
      false
    end
  end

  def mark_as_read(user)
    # mark user's conversations as read
    if self.user == user
      self.update(user_read_at: Time.zone.now)
    else
      self.update(friend_read_at: Time.zone.now)
    end
  end

  def mark_as_unread(user)
    # mark user's correspondant's conversations as read
    if self.user == user
      self.update(friend_read_at: nil)
    else
      self.update(user_read_at: nil)
    end
  end
end
