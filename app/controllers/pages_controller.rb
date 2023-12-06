class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:profile]

  def home
    if user_signed_in?
      @scans = current_user.scans
      @products = current_user.products
    end
  end

  def show
    @wardrobe = Wardrobe.find(params[:id])
    @products = Product.all
    @product = Product.find_by_id(params[:id])
    if @product
      @average = scores.present? ? (scores.sum / scores.count) : 0
    else
      redirect_to root_path, alert: 'Product not found'
    end

    # @average = calculate_average(@product)
    # redirect_to product_fabric_path(@product_fabric, average: @average)
  end

  def profile
    @user = current_user
  end

  def score
  end

  def climate
  end

  def water
  end

  def waste
  end

  def land
  end

  def integrity
  end

  def human_rights
  end

  def chemistry
  end

  def biodiversity
  end

  def animal_welfare
  end
end
