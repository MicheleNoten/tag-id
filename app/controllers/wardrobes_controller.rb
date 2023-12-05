class WardrobesController < ApplicationController
  def index
    @products = current_user.wardrobe_products
    @fabrics = Fabric.all
    @categories = Category.all
    if params[:category] && params[:category].length > 1
      @products = @products.where(category_id: params[:category])
    end

    if params[:query]
      @products = @products.global_search(params[:query])
    end
    # >> @products = Product.joins(:product_fabrics).where(product_fabrics: {fabric_id: ["", "1"]})
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
  def show
    @wardrobe = Wardrobe.find(params[:id])
  end
end
