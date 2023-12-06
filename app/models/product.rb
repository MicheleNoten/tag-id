class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :scan, optional: true

  attr_accessor :deleted_items

  has_many :product_fabrics, dependent: :destroy
  has_many :fabrics, through: :product_fabrics
  has_many_attached :photos, dependent: :destroy
  has_many :wardrobes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :brand, :item_name, :made_in, :purchased_in ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    },
    associated_against: {
      category: [:name],
      fabrics: [:name]
    }

    def photos=(attachables)
      attachables = Array(attachables).compact_blank

      if attachables.any?
        attachment_changes["photos"] =
          ActiveStorage::Attached::Changes::CreateMany.new("photos", self, photos.blobs + attachables)
      end
    end

end
