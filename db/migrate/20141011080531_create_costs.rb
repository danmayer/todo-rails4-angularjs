class CreateCosts < ActiveRecord::Migration
  def change    
    create_table :costs do |t|
      t.belongs_to :trip
      t.string :title, null: false
      t.text :notes, null: true
      t.float :estimate
      t.integer :quantity
      t.float :final_total
      t.integer :priority
      t.boolean :paid, null: false, default: false
      
      t.timestamps
    end
    
    add_index :costs, :id
    add_index :costs, :trip_id
  end
end
