class User < ApplicationRecord
  has_one_attached :avatar

  belongs_to :user_role

  has_many :articles_comments
  has_many :updates_comments

  has_many :article_likes
  has_many :articles, through: :article_likes

  has_many :subscriber_subscriptions, class_name: 'Subscription', foreign_key: 'subscriber_id', dependent: :destroy
  has_many :subscribed_subscriptions, class_name: 'Subscription', foreign_key: 'subscribed_id', dependent: :destroy

  has_many :article_bookmarks
  has_many :articles, through: :article_bookmarks

  has_many :event_bookmarks
  has_many :events, through: :event_bookmarks

  has_many :subscribers, through: :subscribed_subscriptions, source: :subscriber
  has_many :subscribed_users, through: :subscriber_subscriptions, source: :subscribed
  has_many :event_likes, dependent: :destroy
  has_many :event_likes, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
