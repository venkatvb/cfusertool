class AddTagsToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :tags, :string
  end
end
