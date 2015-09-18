class Todo < ActiveRecord::Base
  belongs_to :account
  attr_accessible :description, :name, :url

  validates :name, :presence => true
  validates :account_id, :presence => true
end
