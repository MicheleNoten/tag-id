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
  new = Fibre.create! do |fibre|
    fibre.material = row['material']
    fibre.material_standard = row['material_standard']
    fibre.material_standard_combined = row['material_standard_combined']
    fibre.scoring_type = row['scoring_type']
    fibre.climate = row['climate']
    fibre.water = row['water']
    fibre.chemistry = row['chemistry']
    fibre.land = row['land']
    fibre.biodiversity = row['biodiversity']
    fibre.resource_use_and_waste = row['resource_use_and_waste']
    fibre.human_rights = row['human_rights']
    fibre.animal_welfare = row['animal_welfare']
    fibre.integrity = row['integrity']
  end
  p new
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
  name: "t-shirt"
)

jeans = Category.create!(
  name: "jeans"
)

sportwear = Category.create!(
  name: "sportwear"
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
  scan: Scan.first,
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
  scan: Scan.first,
  item_name: "Blue yoga shorts",
  made_in: "Sri Lanka",
  brand: "Lululemon",
  purchased_in: "Madrid",
  certification_label: "GRS",
  comments: "Great for yoga",
  description: "New yoga shorts",
  score: 1,
)

puts Fabric.create!(
  name: "Cotton",
  weighted_average_performance: 84,
  weighted_average_score: 3
)

Fabric.create!(
  name: "Polyester",
  weighted_average_performance: 34,
  weighted_average_score: 1
)

puts ProductFabric.create!(
  fabric: Fabric.first,
  product: Product.first,
  fabric_percent: 100
)

ProductFabric.create!(
  fabric: Fabric.last,
  product: Product.last,
  fabric_percent: 80
)

puts Sdg.create!(
  name: "Water",
  description: "This indicator measures the adaptive monitoring of water resources related to withdrawal. Monitoring will focus on pressures degrading water resources, the state of water resources, and the effectiveness of monitoring-based actions. Together, these create the Pressure, State, Response (PSR) framework. Within this framework, the indicators are linked such that a change in pressure with regard to water will result in a corresponding move with the state of the water resources.",
  score: 3
)

Sdg.create!(
  name: "Climate",
  description: "This indicator evaluates the implementation of long term climate resiliency methods to protect against extreme weather events. Climate resiliency is measured through the adoption of actions to prevent and minimize climate change disruption. This indicator focuses on establishing a programs adopted onsite practices, technology adoptions, and financial support.",
  score: 2
)

puts SdgFabric.create!(
  sdg: Sdg.first,
  fabric: Fabric.first
)

SdgFabric.create!(
  sdg: Sdg.first,
  fabric: Fabric.first
)

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
