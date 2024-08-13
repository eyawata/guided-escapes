class Experience < ApplicationRecord

  belongs_to :user

  validates :title, presence: true
  validates :duration, presence: true
  validates :content, presence: true
  validates :location, presence: true
  validates :price, presence: true
end
