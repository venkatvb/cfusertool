class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :handle
      t.references :account

      t.timestamps
    end
    add_index :friends, :account_id
  end
end
