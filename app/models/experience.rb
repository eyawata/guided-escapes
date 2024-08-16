class Experience < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  has_many :bookings
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :duration, presence: true
  validates :content, presence: true
  validates :location, presence: true
  validates :price, presence: true
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  include PgSearch::Model
  pg_search_scope :search_by_title_and_content,
  against: [ :title, :content ],
  using: {
    tsearch: { prefix: true } # <-- now `superman batm` will return something!
  }
end
