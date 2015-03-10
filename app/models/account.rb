class Account < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :remember_token
  has_many :friends
  
  has_secure_password	#This one made the magic for you :) google it :)
  # write the test for the email is sotred as downcase in databse
  before_save { |account| account.email = email.downcase }
  # write the test for no whitespaces before or after the handle in name field
  before_save { |account| account.name = name.strip }
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, :presence => true, :length => { :maximum => 50, :minimum => 6 }
  validates :email, :presence => true, :format => { :with => VALID_EMAIL_REGEX }, 
  			:uniqueness => { :case_sensitive => false }
  validates :password, :presence => true, :length => { :minimum => 6 }
  validates :password_confirmation, :presence => true

  private 
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end
end
