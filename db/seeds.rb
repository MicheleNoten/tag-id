
require 'csv'
puts "Destroying entries..."
Wardrobe.destroy_all
Bookmark.destroy_all
SdgFabric.destroy_all
Sdg.destroy_all
ProductFabric.destroy_all
Fabric.destroy_all
Product.destroy_all
Category.destroy_all
Scan.destroy_all
User.destroy_all
Fibre.destroy_all

csv_path = Rails.root.join('db', 'fibres.csv')
CSV.foreach(csv_path, headers: true) do |row|
  p row
  fibre = Fibre.create!(
    material: row['Material'].downcase.strip,
    material_standard: row['Type'].downcase.strip,
    material_standard_combined: row['material_type'].downcase.strip,
    scoring_type: row['Scoring'].downcase.strip,
    climate: row['Climate'],
    water: row['Water'],
    chemistry: row['Chemistry'],
    land: row['Land'],
    biodiversity: row['Biodiversity'],
    resource_use_and_waste: row['Resource use & waste'],
    human_rights: row['Human Rights'],
    animal_welfare: row['Animal Welfare'],
    integrity: row['Integrity']
  )
  p fibre

  categories = ["Water", "Climate", "Chemistry", "Land", "Biodiversity", "Resource use & waste", "Human Rights", "Animal Welfare", "Integrity"]

  fabric = Fabric.create!(
    name: row['material_type'].downcase.strip
  )

  categories.each do |category|
    sdg = Sdg.create!(
      name: category,
      description: "This indicator measures the adaptive monitoring of water resources related to withdrawal. Monitoring will focus on pressures degrading water resources, the state of water resources, and the effectiveness of monitoring-based actions. Together, these create the Pressure, State, Response (PSR) framework. Within this framework, the indicators are linked such that a change in pressure with regard to water will result in a corresponding move with the state of the water resources.",
      score: row[category]
    )

    SdgFabric.create!(
      sdg: sdg,
      fabric: fabric
    )
  end
  p fabric.sdgs.pluck(:score).count
  if fabric.sdgs.pluck(:score).count == 0
    fabric.weighted_average_score = 0
  else
    fabric.weighted_average_score = fabric.sdgs.pluck(:score).sum / fabric.sdgs.pluck(:score).count
  end
  # DO THE WEIGHTED AVERAGE IMPACT SCORES
  fabric.save!
end

puts "Creating entries..."

puts User.create!(
  email: "ankit@test.com",
  password: "123456",
  first_name: "Ankit",
  last_name: "Kanid",
  address: "123 Canggu Street"
)

User.create!(
  email: "michele@test.com",
  password: "123456",
  first_name: "Michele",
  last_name: "Noten",
  address: "123 Perarenan Street"
)

User.create!(
  email: "kim@test.com",
  password: "123456",
  first_name: "Kim",
  last_name: "Kardashian",
  address: "123 Seminyak Street"
)

puts tshirt = Category.create!(
  name: "Tshirt"
)

jeans = Category.create!(
  name: "Jeans"
)

sportwear = Category.create!(
  name: "Sportwear"
)

shorts = Category.create!(
  name: "Shorts"
)

dress = Category.create!(
  name: "Dress"
)

skirt = Category.create!(
  name: "Skirt"
)

Scan.create!(
  user: User.first,
)

Scan.create!(
  user: User.first,
)

Scan.create!(
  user: User.first,
)

puts Product.create!(
  user: User.first,
  category: tshirt,
  scan: Scan.first,
  item_name: "White baggy t-shirt",
  made_in: "China",
  brand: "H&M",
  purchased_in: "Jakarta",
  certification_label: "GOTS",
  comments: "I love this t-shirt",
  description: "This is a white baggy t-shirt",
  score: 2,
)

Product.create!(
  user: User.first,
  category: jeans,
  scan: Scan.second,
  item_name: "Black boyfriend jeans",
  made_in: "Portugal",
  brand: "Cos",
  purchased_in: "Bali",
  certification_label: " ",
  comments: "Favourite jeans",
  description: "Worn in jeans",
  score: 3,
)

Product.create!(
  user: User.first,
  category: sportwear,
  scan: Scan.third,
  item_name: "Blue yoga shorts",
  made_in: "Sri Lanka",
  brand: "Lululemon",
  purchased_in: "Madrid",
  certification_label: "GRS",
  comments: "Great for yoga",
  description: "New yoga shorts",
  score: 1,
)

# puts Fabric.create!(
#   name: "Cotton",
#   weighted_average_performance: ,
#   weighted_average_score: 3
# )

# Fabric.create!(
#   name: "Polyester",
#   weighted_average_performance: 34,
#   weighted_average_score: 1
# )

# puts ProductFabric.create!(
#   fabric: Fabric.first,
#   product: Product.first,
#   fabric_percent: 100
# )

# ProductFabric.create!(
#   fabric: Fabric.last,
#   product: Product.last,
#   fabric_percent: 80
# )

puts Sdg.create!(
  name: "Water",
  description: "This assessment evaluates how well a program manages water-related health risks in fiber cultivation. It checks the effectiveness of a water management plan (WMP) in protecting ecosystems and considering social impacts. At higher levels, the WMP aligns with the local landscape. The adaptive monitoring of water resources assesses pressures, state, and responses, linking changes in pressure to water resource states.
  The evaluation also measures a program's ambition to prioritize water areas for withdrawal and contamination, considering expansion, intensification, and positive outcomes. It checks the comprehensiveness of a water health strategy, evaluating all possible sources of consumption or contamination in the production system. Another indicator addresses the impact of water pollution risk from oil and gas extraction, aiming to reduce chemicals in fiber production and promote renewable energy sources.",
)

Sdg.create!(
  name: "Climate",
  description: "This review checks how well a program manages the environmental impact of growing fibers, like cotton, by looking at how they handle greenhouse gas emissions. It checks if their plan protects nature, fits with the local environment, and thinks about the community. The review also looks at how they keep an eye on these emissions, using different methods and getting a third party to check. It's unique because it focuses a lot on tracking emissions. The review also checks how serious the program is about reducing these emissions, thinking about the land, and using cleaner ways to make fibers. It even looks at how prepared the program is for extreme weather. Additionally, it sees if the program helps in identifying and preserving areas with a lot of carbon, both below and above the ground. Lastly, it understands that measuring how much carbon the soil keeps is tough but encourages more research for better data.",
)

Sdg.create!(
  name: "Chemistry",
  description: "This evaluation assesses a program's chemical management for fibers and materials. It checks the CMP's structure for ecosystem protection and risk evaluation. It also assesses systems minimizing risk and chemical volume, emphasizing control and closed-loop recovery. Adaptive monitoring focuses on every aspect, using third-party verification and tracking against targets. It measures a program's ambition in chemical management, considering expansion, intensification, and positive outcomes. The assessment also checks the strategy's comprehensiveness, considering all possible sources of discharge within the production system.",
)

Sdg.create!(
  name: "Land Use",
  description: "This assessment checks a program's plan for cultivating fibers and materials in relation to soil health. It reviews the structure of a soil health management plan (SHMP) as a tool for protecting soil ecosystems and considering social and environmental impacts. At higher levels, the SHMP evaluates risks and aligns with the local landscape. Another aspect is adaptive monitoring of soil, using the Pressure, State, Response (PSR) framework to link changes in pressure to corresponding moves in soil state. The evaluation also measures a program's ambition in soil health, considering expansion, intensification, the importance of soil health, continuous improvement, and positive outcomes. Another aspect is protecting natural habitats through set-asides, minimizing impacts, and enhancing through active management and restoration.",
)

Sdg.create!(
  name: "Biodiversity",
  description: "
  This assessment focuses on conserving biodiversity in areas like farms or processing facilities. It evaluates the structure of a biodiversity management plan (BMP) to protect ecosystems, considering social and environmental impacts. The BMP, at higher levels, evaluates risks and aligns with the local landscape. Adaptive monitoring of biodiversity can focus on pressures causing loss, state of biodiversity, or monitoring-based actions, using the Pressure State, Response (PSR) framework. It emphasizes restoring habitat diversity through native species introduction, riparian area restoration, and habitat corridor conservation.",
)

Sdg.create!(
  name: "Resource Use & Waste",
  description: "This set of indicators evaluates waste management practices and strategies in production. The first one assesses plans and procedures for waste mitigation, emphasizing the commitment to tracking and separating raw material usage, alongside a long-term waste reduction strategy. The second indicator measures the efficiency of waste stream utilization tracking, utilization strategy, and the level of circularity in practices. The third indicator focuses on the amount of feedstock sourced from certified organic agricultural waste, post-consumer waste, or post-industrial waste.",
)

Sdg.create!(
  name: "Animal Welfare",
  description: "This set of indicators evaluates animal welfare practices and strategies in fiber cultivation. The first indicator assesses the structure of an animal welfare management plan (AWMP) to protect flocks, ensuring social and environmental impacts are considered. The second indicator measures adaptive monitoring of animal welfare, focusing on pressures, the state of animal welfare, and monitoring-based actions using the Pressure, State, Response (PSR) framework. The third indicator examines a program's ambition in animal welfare, considering expansion, intensification, the importance of animal welfare, and positive outcomes.",
)

Sdg.create!(
  name: "Human Rights",
  description: "This program ensures fair treatment for hired workers regarding wage levels, working hours, leave, and employment terms. It prohibits forced labor, addressing associated risks. It combats the worst forms of child labor, monitoring and remediating risks. Requirements for non-discrimination and equal opportunity are in place, evaluated to ensure producers prevent and respond to discrimination. The program supports freedom of association and collective bargaining. It mandates safe working conditions, evaluating producers' efforts. The program aims to increase incomes for small producers and improve income predictability. Requirements include respecting land tenure and customary rights, with credible evaluations. Similar provisions exist for land and water rights. The program promotes participation in democratic processes, considering state-imposed limitations.",
)

Sdg.create!(
  name: "Integrity",
  description: "This outlines rules for a sustainable certification group. They need to clearly say how they're making good impacts on the world and what plans they have. The people in charge must be fair and open, and they need clear rules for checking if things are done right. There are checks to make sure the people doing the checks are doing it well. If something goes wrong, there are easy ways to complain or give feedback. Overall, they should keep learning and telling everyone how they're doing.",
)

# puts SdgFabric.create!(
#   sdg: Sdg.first,
#   fabric: Fabric.first
# )

# SdgFabric.create!(
#   sdg: Sdg.first,
#   fabric: Fabric.first
# )

puts Bookmark.create!(
  user: User.first,
  product: Product.first
)

Bookmark.create!(
  user: User.last,
  product: Product.last
)

puts Wardrobe.create!(
  user: User.first,
  product: Product.first
)

Wardrobe.create!(
  user: User.last,
  product: Product.last
)

puts "Finished!"
