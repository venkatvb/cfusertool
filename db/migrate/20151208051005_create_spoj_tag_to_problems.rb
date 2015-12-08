class CreateSpojTagToProblems < ActiveRecord::Migration
  def change
    create_table :spoj_tag_to_problems do |t|
      t.integer :tagId
      t.integer :problemId

      t.timestamps
    end
  end
end
