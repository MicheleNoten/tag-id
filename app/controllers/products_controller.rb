class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @products = Product.all
    @product = Product.find_by_id(params[:id])

    if @product
      scores = @product.product_fabrics.map { |product_fabric| product_fabric.fabric_percent/100.0 * product_fabric.fabric.weighted_average_score }
      @average = scores.present? ? (scores.sum / scores.count) : 0
    else
      redirect_to root_path, alert: 'Product not found'
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      params[:product][:counter].to_i.times do |index|
        fabric_type_params = params["fabric_type_#{index + 1}"]
        fabric_composition_params = params["fabric_composition_#{index + 1}"]
        fabric = Fabric.find_by_name(fabric_type_params.downcase)
        ProductFabric.create(product: @product, fabric: fabric, fabric_percent: fabric_composition_params)
      end
      redirect_to product_path(@product), notice: 'Product was successfully created.'
    else
      render :new
    end
  end

      # ProductFabric.create(product: @product, fabric: Fabric.find_by_name(params[:fabric_type_1].downcase), fabric_percent: params[:fabric_composition_1]) if params[:fabric_type_1].present?
      # ProductFabric.create(product: @product, fabric: Fabric.find_by_name(params[:fabric_type_2].downcase), fabric_percent: params[:fabric_composition_2]) if params[:fabric_type_2].present?
      # redirect_to product_path(@product), notice: 'Product was successfully created.'

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

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to root_path, notice: 'Product was successfully deleted.'
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
