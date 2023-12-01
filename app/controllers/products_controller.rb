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
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      ProductFabric.create(product: @product, fabric: Fabric.find_by_name(params[:fabric_type_1].downcase), fabric_percent: [:fabric_composition_1]) if params[:fabric_type_1].present?
      ProductFabric.create(product: @product, fabric: Fabric.find_by_name(params[:fabric_type_2].downcase), fabric_percent: [:fabric_composition_2]) if params[:fabric_type_2].present?
      redirect_to product_path(@product), notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path(@product), notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:item_name, :made_in, :brand, :purchased_in, :certification_label, :comments,
                                    :description, :score, :category_id, :scan_id, :user_id, photos: [])
  end

  def fabric_types
    params.require(:fabric_types).permit(fabric_types: [])
  end

end
