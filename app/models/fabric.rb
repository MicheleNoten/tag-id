class Fabric < ApplicationRecord
  has_many :sdg_fabrics
  has_many :sdgs, through: :sdg_fabrics

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name ],
    using: :tsearch
end
