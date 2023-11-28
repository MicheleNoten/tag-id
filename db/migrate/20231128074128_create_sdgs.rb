class CreateSdgs < ActiveRecord::Migration[7.1]
  def change
    create_table :sdgs do |t|
      t.string :name
      t.text :description
      t.integer :score
      t.integer :impact_performance

      t.timestamps
    end
  end
end
