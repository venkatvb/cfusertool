class FriendsController < ApplicationController
	def new
		@friend = Friend.new
	end

	def create
		#contents = params[:friend]
		#h = Hash.new({:name => "cv"})
		#raise params[:friends].inspect
		@friend = Friend.new(params[:friends])
	  	if @friend.save
	  		#saved successful
	  	else
	  		render 'new'
	  	end
	end

end
