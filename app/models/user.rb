class User < ApplicationRecord
  has_many :posts
  has_attached_file :image, styles: { large: ["500x500>", :jpg], medium: ["250x250>", :jpg], thumb: ["80x80", :jpg] }, default_url: "/assets/default.png"
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
    !self.friends.where(id: friend.id).empty?
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
end
