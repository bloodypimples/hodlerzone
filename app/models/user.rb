class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, presence: true
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  def get_friendship(friend)
    Friendship.where(user_id: self.id, friend_id: friend.id)
    .or(Friendship.where(user_id: friend.id, friend_id: self.id))
  end

  def get_all_friends
    self.friends + self.inverse_friends
  end
end
