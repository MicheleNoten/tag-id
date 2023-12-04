class Bookmark < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :user, uniqueness: { scope: :product}
end
