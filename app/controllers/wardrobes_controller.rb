class WardrobesController < ApplicationController

  def index_products
    @products = Product.all
  end
  
end
