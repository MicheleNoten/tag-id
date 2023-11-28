class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :scan

  has_many :product_fabrics
  has_many_attached :photos
end
