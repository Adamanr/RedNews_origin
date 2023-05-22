class Event < ApplicationRecord
  belongs_to :user
  has_one_attached :header
  acts_as_taggable_on :tags
  is_impressionable counter_cache: true, column_name: :impressions_count
  belongs_to :user
  has_many :event_comments

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :event_bookmarks
  has_many :users, through: :event_bookmarks

  def like(user)
    liked_users << user unless liked_users.include?(user)
    update(likes_count: likes_count + 1)
  end

  validates :header, presence: true
  validates :title, presence: true, length: { in: 10..100 }
  validates :body, presence: true, length: { in: 150..10000 }
end
