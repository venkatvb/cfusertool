class Friend < ActiveRecord::Base
  belongs_to :account
  attr_accessible :handle
end
