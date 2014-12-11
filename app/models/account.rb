class Account < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password	#This one made the magic for you :) google it :)

  before_save { |account| account.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, :presence => true, :length => { :maximum => 50, :minimum => 6 }
  validates :email, :presence => true, :format => { :with => VALID_EMAIL_REGEX }, 
  			:uniqueness => { :case_sensitive => false }
  validates :password, :presence => true, :length => { :minimum => 6 }
  validates :password_confirmation, :presence => true
end
