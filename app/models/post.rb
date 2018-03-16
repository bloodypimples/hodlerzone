class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, class_name: "Post", foreign_key: "post_id"
end
