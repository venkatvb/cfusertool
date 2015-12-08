class CreateSpojUserToProblems < ActiveRecord::Migration
  def change
    create_table :spoj_user_to_problems do |t|
      t.integer :userId
      t.integer :problemId
      t.boolean :solved

      t.timestamps
    end
  end
end
