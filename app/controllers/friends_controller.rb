class FriendsController < ApplicationController
	
	def new
		if signed_in?
			@friend = Friend.new
		else
			render 'users/index'	
		end
	end

	def create
		#contents = params[:friend]
		#h = Hash.new({:name => "cv"})
		#raise params[:friends].inspect
		if signed_in?
			@friend = Friend.new(params[:friends])
			@friend.account_id = get_account_id
		  	if @friend.save
		  		#saved successful
		  	else
		  		render 'new'
		  	end
		else
			render 'new'
		end
	end

end
