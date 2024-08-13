class BookingsController < ApplicationController
  def index
    @user = current_user
    @bookings = @user.bookings
  end

  def create
  end
end
