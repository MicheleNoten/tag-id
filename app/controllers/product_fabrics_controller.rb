class ProductFabricsController < ApplicationController
  def show
    @product_fabric = ProductFabric.find(params[:id])
  end

  private

  def product_fabric_params
    params.require(:product_fabric).permit(:product_id, :fabric_id)
  end
end
