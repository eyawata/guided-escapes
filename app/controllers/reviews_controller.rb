class ReviewsController < ApplicationController
  before_action :set_experience, only: %i[new create]

  def new
    # We need @restaurant in our `simple_form_for`
    @experience = Experience.find(params[:experience_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.experience = @experience
    @review.user = current_user
    @booking = Booking.new
    if @review.save
      redirect_to experience_path(@experience)
    else
      render "experiences/show", status: :unprocessable_entity
    end
  end

  private

  def set_experience
    @experience = Experience.find(params[:experience_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
