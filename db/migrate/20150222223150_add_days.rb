class AddDays < ActiveRecord::Migration
  def change
    add_column :trip_destinations, :days, :integer, default: 30
  end
end
