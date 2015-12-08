class AddColumnToSpojHandle < ActiveRecord::Migration
  def change
    add_column :spoj_handles, :solved, :string
    add_column :spoj_handles, :todo, :string
  end
end
