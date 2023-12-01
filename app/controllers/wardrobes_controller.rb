class WardrobesController < ApplicationController
  def index
    @wardrobes = Wardrobe.all
  end

  def index_products
    @products = Product.all
  end
end
