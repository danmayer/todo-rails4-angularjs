class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.belongs_to :trip
      t.string :title, null: false
      t.text :options

      t.timestamps
    end

    add_index :destinations, :trip_id
    add_index :destinations, :id
  end
end
