class ExperiencesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @experiences = Experience.all
    @markers = @experiences.geocoded.map do |experience|
      {
        lat: experience.latitude,
        lng: experience.longitude
      }
    end
  end

  def show
    @experience = Experience.find(params[:id])
    @reviews = @experience.reviews
    @booking = Booking.new
    @review = Review.new
  end
end
