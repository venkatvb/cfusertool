class FriendsController < ApplicationController
	def new
		@friend = Friend.new
	end

	def create
		contents = params[:friend]
		h = Hash.new(params["friend"])
		@friend = Friend.new(h)
	  	if @friend.save
	  		#saved successful
	  	else
	  		render 'new'
	  	end
	end

end
