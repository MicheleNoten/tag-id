class CreateSdgFabrics < ActiveRecord::Migration[7.1]
  def change
    create_table :sdg_fabrics do |t|
      t.references :fabric, null: false, foreign_key: true
      t.references :sdg, null: false, foreign_key: true

      t.timestamps
    end
  end
end
