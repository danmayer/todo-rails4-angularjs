class TripDefaults < ActiveRecord::Migration
  def change
    add_column :trips, :default_options, :text
    add_column :trips, :days, :integer, :default => 30
  end
end
