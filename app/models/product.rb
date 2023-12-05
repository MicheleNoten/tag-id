class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :scan, optional: true

  has_many :product_fabrics
  has_many_attached :photos

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :brand, :item_name ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    },
    associated_against: {
      category: [ :name ]
    }
end
