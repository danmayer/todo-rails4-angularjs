class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.belongs_to :owner
      t.title

      t.timestamps
    end

    add_index :trips, :owner_id
  end
end
