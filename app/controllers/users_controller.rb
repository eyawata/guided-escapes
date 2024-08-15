class UsersController < ApplicationController
  def show
    @user = current_user
    @experiences = @user.experiences
    @reviews = @experiences.map {|experience| experience.reviews }
  end
end
