class RenameDestinationOptions < ActiveRecord::Migration
  def change
    add_column :destinations, :default_options, :text
    remove_column :destinations, :options
  end
end
