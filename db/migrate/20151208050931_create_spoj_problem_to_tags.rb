class CreateSpojProblemToTags < ActiveRecord::Migration
  def change
    create_table :spoj_problem_to_tags do |t|
      t.integer :problemId
      t.integer :tagId

      t.timestamps
    end
  end
end
