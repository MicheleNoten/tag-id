class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :scan, optional: true

  has_many :product_fabrics, dependent: :destroy
  has_many_attached :photos, dependent: :destroy
  has_many :wardrobes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
end
