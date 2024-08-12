class Review < ApplicationRecord
  belongs_to :experience
  belongs_to :user

  validates :experience, presence: true
  validates :user, presence: true
  validates :content, presence: true
  validates :rating, presence: true
end
