class UserAddDetails < ActiveRecord::Migration
  def change
    add_column :users, :home_country, :string, null: true
    add_column :users, :default_currency, :string, null: true, default: 'USD'
  end
end
