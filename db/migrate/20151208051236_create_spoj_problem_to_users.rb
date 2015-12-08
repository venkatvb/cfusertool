class CreateSpojProblemToUsers < ActiveRecord::Migration
  def change
    create_table :spoj_problem_to_users do |t|
      t.integer :problemId
      t.integer :userId
      t.boolean :solved

      t.timestamps
    end
  end
end
