class AddColumnToSpojProblem < ActiveRecord::Migration
  def change
    add_column :spoj_problems, :code, :string
    add_index :spoj_problems, :code, :unique => true
  end
end
