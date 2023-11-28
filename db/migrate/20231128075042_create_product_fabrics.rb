class CreateProductFabrics < ActiveRecord::Migration[7.1]
  def change
    create_table :product_fabrics do |t|
      t.references :product, null: false, foreign_key: true
      t.references :fabric, null: false, foreign_key: true
      t.integer :fabric_percent

      t.timestamps
    end
  end
end
