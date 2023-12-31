class WardrobesController < ApplicationController
  def index
    @products = current_user.wardrobe_products
    @product = Product.all
    @product = Product.find_by_id(params[:id])
    @fabrics = Fabric.all
    @categories = Category.all
    # Hot fix : To fix the bug of the average score
    scores = []
    @products.each do |product|
      product_fabrics_score = product.product_fabrics.map { |product_fabric| product_fabric.fabric_percent/100.0 * product_fabric.fabric.weighted_average_score }
      scores << ((product.product_fabrics.empty?) ? 0 : (product_fabrics_score.sum / product.product_fabrics.count))
    end

    @average = (scores.empty? || scores.count == 0) ? 0 : (scores.sum / scores.count)

    # End of code for Hot fix

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

  def edit
    @product = Product.find_by_id(params[:id])
  end

  def create
    @product = Product.find(params[:product_id])
    Wardrobe.create(user: current_user, product: @product)

    # bookmark = Bookmark.find_by_product_id(@product)
    # bookmark.destroy

    bookmark = Bookmark.find_by_product_id(@product)
    bookmark.destroy if bookmark

    # current_user.wardrobe_products << @product
    redirect_to wardrobes_path
  end

  def destroy
    @product = Product.find(params[:id])
    Wardrobe.find_by_product_id(@product).destroy
    redirect_to wardrobes_path
  end

  private

  def product_params
    params.require(:product).permit(:item_name, :made_in, :brand, :purchased_in, :certification_label, :comments,
                                    :description, :score, :category_id, :scan_id, :user_id, photos: [])
  end
end
