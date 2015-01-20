class UpdateTripsDestinations < ActiveRecord::Migration
  def change
    add_column :destinations_trips, :arrival, :datetime, null: true
  end
end
