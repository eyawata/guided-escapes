class BookingsController < ApplicationController
  def index
  end

  def create
    @booking = Booking.new()
    @user = current_user
    @experience = Experience.find(params[:id])
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
