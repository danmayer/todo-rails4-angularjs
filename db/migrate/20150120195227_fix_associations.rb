class FixAssociations < ActiveRecord::Migration
  def change
    rename_table :destinations_trips, :trip_destinations
    add_column :trip_destinations, :id, :primary_key
    add_index :trip_destinations, :id
    
    remove_column :costs, :destination_id
    remove_index :costs, :destination_id if index_exists?(:costs, :destination_id)
    add_column :costs, :trip_destinations_id, :integer, null: true    
    add_index :costs, :trip_destinations_id
  end
end
