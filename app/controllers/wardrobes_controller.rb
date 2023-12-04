class WardrobesController < ApplicationController
  def index
    @wardrobes = Wardrobe.all
  end

  def index_products
    @products = Product.all
  end

  def show
    @wardrobe = Wardrobe.find(params[:id])
  end

  def create
    @product = Product.find(params[:product_id])
    current_user.wardrobe.products << @product
    redirect_to wardrobes_path, notice: 'Product added to wardrobe successfully.'
  end
end
