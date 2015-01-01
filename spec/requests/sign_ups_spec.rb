require 'spec_helper'

describe "user pages" do
	describe "signup" do
		before { visit new_account_path }
		let(:submit) { "create my account" }
		describe "with invalid information" do
			it "should not create an account" do
				expect { click_button submit }.not_to change(Account, :count)
			end
		end

		describe "with valid information " do
			before do
				fill_in "account_name", with: "sample user"
				fill_in "account_email", with: "sampleemail@something.com"
				fill_in "account_password", with: "foobar"
				fill_in "account_password_confirmation", with: "foobar"
			end

			it "should create an account" do
				expect { click_button submit }.to change(Account, :count).by(1)
			end
		end

		describe "with password mismatch" do

			before do
				fill_in "account_name", with: "sample user"
				fill_in "account_email", with: "sampleemail@something.com"
				fill_in "account_password", with: "foobar"
				fill_in "account_password_confirmation", with: "mismatch"
			end

			it "should not create an account" do
				expect { click_button submit }.not_to change(Account, :count)
			end
		end

	end
end