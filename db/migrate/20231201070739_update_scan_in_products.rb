class UpdateScanInProducts < ActiveRecord::Migration[7.1]
  def change
    change_column_null :products, :scan_id, true
  end
end
