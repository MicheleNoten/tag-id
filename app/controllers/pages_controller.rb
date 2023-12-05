class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:profile ]

  def home
    if user_signed_in?
    @scans = current_user.scans
    end 
  end

  def profile
    @user = current_user
  end

  def score
  end
end
