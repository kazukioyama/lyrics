class Post < ApplicationRecord
  belongs_to :user
  has_many :answers
  mount_uploader :image, ImageUploader
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
end
