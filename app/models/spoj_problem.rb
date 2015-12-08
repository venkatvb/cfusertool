class SpojProblem < ActiveRecord::Base
  	attr_accessible :accepted, :compilationError, :conceptualDifficulty, :downvote, :implementationDifficulty, :runtimeError, :setter, :submissions, :timeLimitExceeded, :upvote, :usersAccepted, :wrongAnswer, :code
  	validates :code, :presence => true, :uniqueness => { :case_sensitive => false }
end
