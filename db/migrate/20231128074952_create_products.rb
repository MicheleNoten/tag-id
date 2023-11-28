class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :item_name
      t.string :made_in
      t.string :brand
      t.references :category, null: false, foreign_key: true
      t.string :purchased_in
      t.string :certification_label
      t.text :comments
      t.text :description
      t.integer :score
      t.references :user, null: false, foreign_key: true
      t.references :scan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
