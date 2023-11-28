class Scan < ApplicationRecord
  belongs_to :user

  has_one_attached :photo
  has_one :product
end
