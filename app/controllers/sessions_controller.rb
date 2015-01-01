class SessionsController < ApplicationController
	def new
		@current_account = nil
	end

	def create
		account = Account.find_by_email(params[:session][:email])
		if account && account.authenticate(params[:session][:password])
			#success
			sign_in account
			redirect_to account
		else
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to "/"
	end
end
