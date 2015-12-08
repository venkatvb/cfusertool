class SpojHandle < ActiveRecord::Base
  attr_accessible :handle, :name, :solved, :todo
  validates :handle, :presence => true, :uniqueness => { :case_sensitive => true }
end
