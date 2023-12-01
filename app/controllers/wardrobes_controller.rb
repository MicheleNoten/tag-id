class WardrobesController < ApplicationController
  def index
    @wardrobes = Wardrobe.all

  def index_products
    @products = Product.all
  end
  
end
