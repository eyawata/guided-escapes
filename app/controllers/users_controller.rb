class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @experiences = @user.experiences
  end
end
