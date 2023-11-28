class CreateScans < ActiveRecord::Migration[7.1]
  def change
    create_table :scans do |t|
      t.string :request_chatgpt
      t.string :response_chatgpt
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
