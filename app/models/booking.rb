class Booking < ApplicationRecord
  belongs_to :experience
  belongs_to :user

  validates :experience, presence: true
  validates :user, presence: true
  validates :date, presence: true

  enum status: [ :pending, :accepted, :rejected, :archived ]
end
