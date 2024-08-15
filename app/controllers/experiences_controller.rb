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

  def new
    @experience = Experience.new
  end

  def create
    @experience = Experience.new(experience_params)
    @experience.user = current_user
    if @experience.save
      redirect_to @experience, notice: 'Experience was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def experience_params
    params.require(:experience).permit(:location, :title, :content, :duration, :price, photos: [])
  end
end
