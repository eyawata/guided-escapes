class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @experience = Experience.all.sample
  end
end
