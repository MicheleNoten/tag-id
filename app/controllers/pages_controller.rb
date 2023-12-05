class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :profile ]

  def home
    @scans = current_user.scans
  end

  def profile
    @user = current_user
  end

  def score
  end
end
