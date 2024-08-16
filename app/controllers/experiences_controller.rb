class ExperiencesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      @experiences = Experience.search_by_title_and_content(params[:query])
    else
      @experiences = Experience.all
    end


    @markers = @experiences.geocoded.map do |experience|
      {
        lat: experience.latitude,
        lng: experience.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { experience: experience })
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
