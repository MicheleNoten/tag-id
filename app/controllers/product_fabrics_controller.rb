class ProductFabricsController < ApplicationController

  def show
    @product_fabric = ProductFabric.find(params[:id])
    @product = @product_fabric.product

    @product_fabric = ProductFabric.find(params[:id])
    @average = params[:average].to_f if params[:average]
  end

  private

  def product_fabric_params
    params.require(:product_fabric).permit(:product_id, :fabric_id)
  end
end
