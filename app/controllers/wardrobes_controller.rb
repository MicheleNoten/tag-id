class WardrobesController < ApplicationController
  def index
    @wardrobes = Wardrobe.all
  end
end
