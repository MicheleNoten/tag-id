class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :scan
end
