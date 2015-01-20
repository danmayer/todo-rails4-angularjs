class UpdateCosts < ActiveRecord::Migration
  def change
    add_column :costs, :destination_id, :integer, null: true
    change_column :costs, :estimate, :float, :default => 0.0
    change_column :costs, :quantity, :integer, :default => 1
    
    add_index :costs, :destination_id
  end
end
