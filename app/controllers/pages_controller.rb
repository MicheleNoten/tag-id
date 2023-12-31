class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:profile]

  def home
    if user_signed_in?
      @scans = current_user.scans
      @products = current_user.products
      # Hot fix : To fix the bug of the average score
      scores = []
      current_user.wardrobe_products.each do |product|
        product_fabrics_score = product.product_fabrics.map { |product_fabric| product_fabric.fabric_percent/100.0 * product_fabric.fabric.weighted_average_score }
        scores << ((product.product_fabrics.empty?) ? 0 : (product_fabrics_score.sum / product.product_fabrics.count))
      end
      @average = (scores.empty? || scores.count == 0) ? 0 : (scores.sum / scores.count)
      # End of code for Hot fix
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
