class CreateFabrics < ActiveRecord::Migration[7.1]
  def change
    create_table :fabrics do |t|
      t.integer :weighted_average_score
      t.integer :weighted_average_performance

      t.timestamps
    end
  end
end
