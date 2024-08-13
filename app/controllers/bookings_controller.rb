class BookingsController < ApplicationController
  def index
  end

  def create
    @experience = Experience.find(params[:id])
    @booking = Booking.new()
    @user = current_user
    @booking.user = @user
    @booking.experience = @experience
    if @booking.save
      redirect to experience_path(experience)
    else
      render "#", status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date)
  end
end
