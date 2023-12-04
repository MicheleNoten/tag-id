class WardrobesController < ApplicationController
  def index
    @products = current_user.wardrobe_products
    @fabrics = Fabric.all
    @categories = Category.all
    if params[:category]
      @products = @products.where(category_id: params[:category])
    end
  end

  def index_products
    @products = Product.all
  end

  def create
    @product = Product.find(params[:product_id])
    Wardrobe.create(user: current_user, product: @product)
    bookmark = Bookmark.find_by_product_id(@product)
    bookmark.destroy
    # current_user.wardrobe_products << @product
    redirect_to wardrobes_path
  end

  def destroy
    @product = Product.find(params[:id])
    Wardrobe.find_by_product_id(@product).destroy
    redirect_to wardrobes_path
  end
end
