class AddTokens < ActiveRecord::Migration
  def change
    # was previously added
    #add_column :users, :authentication_token, :string, null: true
    add_index :users, :authentication_token, :unique => true
  end
end
