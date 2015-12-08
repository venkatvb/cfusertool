class ChageColumnToSpojHandle < ActiveRecord::Migration
  def change
  	change_column :spoj_handles, :solved, :text, :limit => nil
  	change_column :spoj_handles, :todo, :text, :limit => nil
  end
end
