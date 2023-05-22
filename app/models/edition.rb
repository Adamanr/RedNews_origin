class Edition < ApplicationRecord
  belongs_to :user
  has_one_attached :logo
end
