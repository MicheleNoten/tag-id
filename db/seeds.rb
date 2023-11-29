puts "Destroying entries..."
Wardrobe.destroy_all
Bookmark.destroy_all
Product.destroy_all
Category.destroy_all
Scan.destroy_all
User.destroy_all

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
