class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @products = Product.all
    @product = Product.find_by_id(params[:id])
    
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params.require(:product).permit(:item_name, :made_in, :brand, :purchased_in, :certification_label, :comments, :description, :score, :category_id, :scan_id, :user_id))
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  private

  def fabric_types
    params.require(:fabric_types).permit(fabric_types: [])
  end

end
