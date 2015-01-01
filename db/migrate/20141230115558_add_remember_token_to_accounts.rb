class AddRememberTokenToAccounts < ActiveRecord::Migration
  def change
  	add_column :accounts, :remember_token, :string
  	add_index :accounts, :remember_token
  end
end
