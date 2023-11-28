class Fabric < ApplicationRecord
  has_many :sdg_fabrics
  has_many :sdgs, through: :sdg_fabrics
end
