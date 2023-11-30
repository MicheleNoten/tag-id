class CreateFibres < ActiveRecord::Migration[7.1]
  def change
    create_table :fibres do |t|
      t.string :material
      t.string :material_standard
      t.string :material_standard_combined
      t.string :scoring_type
      t.integer :climate
      t.integer :water
      t.integer :chemistry
      t.integer :land
      t.integer :biodiversity
      t.integer :resource_use_and_waste
      t.integer :human_rights
      t.integer :animal_welfare
      t.integer :integrity

      t.timestamps
    end
  end
end
