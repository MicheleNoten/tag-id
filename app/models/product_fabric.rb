class ProductFabric < ApplicationRecord
  belongs_to :product
  belongs_to :fabric

  validates :product, uniqueness: { scope: :fabric }
end
