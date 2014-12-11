require 'spec_helper'

describe Account do
	before { @account = Account.new(:name => "venkatvb", :email => "venkateshbabu95@gmail.com", 
			:password => "foobar", :password_confirmation => "foobar" ) }
	subject { @account }
	it { should respond_to :name }
	it { should respond_to :email }
	it { should respond_to :password_digest }
	it { should respond_to :password }
	it { should respond_to :password_confirmation }
	it { should be_valid }
	describe "when account name not present" do
		before { @account.name = " " }
		it { should_not be_valid }
	end
	describe "when account email is not present" do
		before { @account.email = " " }
		it { should_not be_valid }
	end
	describe "when length of the usename is greater than 50 " do
		before { @account.name = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" }
		it { should_not be_valid }
	end
	describe "when length of the username is less than 6" do
		before { @account.name = "ab" }
		it { should_not be_valid }
	end
	#No tests for valid email yet
	describe "when username is already taken " do
		before do
			user_with_same_name = @account.dup
			user_with_same_name.save
		end
		it { should_not be_valid }
	end
	#No tests done for passwords yet
	#MANDATORY -- JUST do IT
end
