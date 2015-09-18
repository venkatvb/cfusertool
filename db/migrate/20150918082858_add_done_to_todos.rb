class AddDoneToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :done, :boolean
  end
end
