class CreateSpojProblems < ActiveRecord::Migration
  def change
    create_table :spoj_problems do |t|
      t.string :setter
      t.integer :conceptualDifficulty
      t.integer :implementationDifficulty
      t.integer :upvote
      t.integer :downvote
      t.integer :usersAccepted
      t.integer :submissions
      t.integer :accepted
      t.integer :wrongAnswer
      t.integer :compilationError
      t.integer :runtimeError
      t.integer :timeLimitExceeded

      t.timestamps
    end
  end
end
