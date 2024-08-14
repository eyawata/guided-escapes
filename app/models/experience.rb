class Experience < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :bookings

  validates :title, presence: true
  validates :duration, presence: true
  validates :content, presence: true
  validates :location, presence: true
  validates :price, presence: true
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
