class UsersController < ApplicationController
  def show
    @user = current_user
    @experiences = @user.experiences
  end
end
