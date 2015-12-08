class SpojProblemToUser < ActiveRecord::Base
  attr_accessible :problemId, :solved, :userId
end
