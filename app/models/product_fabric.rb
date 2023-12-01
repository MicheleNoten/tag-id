class ProductFabric < ApplicationRecord
  belongs_to :product
  belongs_to :fabric

  # def fabric_detail
  #   fibre = Fibre.where("material_standard='no standard' and material_standard_combined like '%#{fabric.name}%'").first
  #   fibre.material_standard_combined
  # end

  # def fabric_impact(fibre_info)
  #   fibre = Fibre.where("material_standard='no standard' and material_standard_combined like '%#{fibre_info}%'").first
  #   if fibre
  #     { material_standard_combined: fibre.material_standard_combined, impact_level: fibre.impact_level }
  #   else
  #     { material_standard_combined: "no standard", impact_level: 0 }
  #   end
  # end
end
