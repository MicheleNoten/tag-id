class AddNameToFabric < ActiveRecord::Migration[7.1]
  def change
    add_column :fabrics, :name, :string
  end
end
