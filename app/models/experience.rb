class Experience < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photo

  validates :title, presence: true
  validates :duration, presence: true
  validates :content, presence: true
  validates :location, presence: true
  validates :price, presence: true
end
