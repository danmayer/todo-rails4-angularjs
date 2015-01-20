class CreateTripsDestinations < ActiveRecord::Migration
  def change
    create_join_table :trips, :destinations do |t|
      t.index :trip_id
      t.index :destination_id
      t.text :notes, null: true
      t.timestamps
    end
    
    remove_column :destinations, :trip_id
  end
end
