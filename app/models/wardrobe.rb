class Wardrobe < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user, uniqueness: { scope: :product}
  # has_many :products, dependent: :destroy
end
