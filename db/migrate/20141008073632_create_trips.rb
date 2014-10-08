class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.belongs_to :owner
      t.string :title, null: false
      t.date :begin_date

      t.timestamps
    end

    add_index :trips, :owner_id
  end
end
