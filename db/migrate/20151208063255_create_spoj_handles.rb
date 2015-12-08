class CreateSpojHandles < ActiveRecord::Migration
  def change
    create_table :spoj_handles do |t|
      t.string :name
      t.string :handle

      t.timestamps
    end
  end
end
