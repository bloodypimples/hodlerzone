class Post < ApplicationRecord
  acts_as_votable
  belongs_to :user
  belongs_to :poster, class_name: "User", foreign_key: "poster_id", optional: true
  has_many :replies, class_name: "Post", foreign_key: "post_id", dependent: :destroy
  validates :body, presence: true
end
