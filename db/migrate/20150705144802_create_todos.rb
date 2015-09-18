class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.references :account
      t.string :name
      t.string :url
      t.text :description
      t.timestamps
    end
    add_index :todos, :account_id
  end
end
