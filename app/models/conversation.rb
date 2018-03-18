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
end
