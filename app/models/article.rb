class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :header
  acts_as_taggable_on :tags
  is_impressionable

  has_many :article_bookmarks
  has_many :users, through: :article_bookmarks

  has_many :articles_comments
  has_many :article_likes, dependent: :destroy


  def like(user)
    liked_users << user unless liked_users.include?(user)
  end

  validates :header, presence: true
  validates :title, presence: true, length: { in: 10..50 }
  validates :body, presence: true, length: { in: 150..10000 }
end
