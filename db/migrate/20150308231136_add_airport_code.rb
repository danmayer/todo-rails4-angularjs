class AddAirportCode < ActiveRecord::Migration
  def change
    add_column :destinations, :airport_code, :text
  end
end
