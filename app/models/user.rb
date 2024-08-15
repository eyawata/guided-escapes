class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :experiences
  has_many :bookings
  has_many :reviews
  has_many :bookings_as_guide, through: :experiences, source: :bookings

  has_one_attached :avatar
end
