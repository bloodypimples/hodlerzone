class User < ApplicationRecord
  has_many :messages
  has_many :posts
  has_many :conversations
  has_many :inverse_conversations, class_name: "Conversation", foreign_key: "friend_id"
  has_attached_file :image, styles: { large: ["500x500>", :jpg], medium: ["250x250>", :jpg], thumb: ["80x80", :jpg] }, default_url: "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&s=200"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  after_commit :compress_image, on: [:create, :update]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, presence: true
  has_many :friendships
  has_many :friends, through: :friendships do
    def accepted
      where("friendships.accepted = ?", true)
    end
  end
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user do
    def accepted
      where("friendships.accepted = ?", true)
    end
  end
  has_many :notifications

  def get_friendship(friend)
    Friendship.where(user_id: self.id, friend_id: friend.id)
    .or(Friendship.where(user_id: friend.id, friend_id: self.id))
  end

  def get_all_friends
    self.friends.accepted + self.inverse_friends.accepted
  end

  def get_unread_alerts
    Notification.where(receiver_id: self.id, read_at: nil)
  end

  def is_friends_with?(friend)
    if self.friends.where(id: friend.id).empty? && self.inverse_friends.where(id: friend.id).empty?
      false
    else
      true
    end
  end

  def compress(image_path)
    system "convert #{image_path} -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace sRGB #{image_path}"
  end

  def compress_image
    if self.image?
      compress(self.image.path(:large))
      compress(self.image.path(:medium))
      compress(self.image.path(:thumb))
    end
  end

  def self.search(q)
    where("first_name LIKE ? or last_name LIKE ? or first_name || ' ' || last_name LIKE ? or last_name || ' ' || first_name LIKE ?", "%#{q}%", "%#{q}%", "%#{q}%", "%#{q}%")
  end

  def get_all_conversations
    Conversation.where("user_id = ? OR friend_id = ?", self.id, self.id).order("created_at desc")
  end

  def full_name
    self.first_name + " " + self.last_name
  end

  def get_unread_messages
    Conversation.where(user_id: self.id, user_read_at: nil)
    .or(Conversation.where(friend_id: self.id, friend_read_at: nil))
  end
end
