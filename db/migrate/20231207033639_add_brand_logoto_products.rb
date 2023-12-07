class AddBrandLogotoProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :brand_logo, :string
  end
end
