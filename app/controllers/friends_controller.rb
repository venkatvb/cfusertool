class FriendsController < ApplicationController
	
	def new
		if signed_in?
			@friend = Friend.new
			@myfriend = Friend.all
			@index = 1
		else
			flash[:danger] = "Oh snap! You should Sign in now! then try again.";
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
			@myfriend
			@index = 1
		  	if @friend.save
		  		#saved successful
		  		@myfriend = Friend.all
		  		flash[:success] = "yay! #{@myfriend.last.handle} is added."
		  		render 'new'
		  	else
		  		flash[:danger] = "Oh something went wrong! please try again later.";
		  		render 'new'
		  	end
		else
			flash[:danger] = "Oh snap! You should Sign in now! then try again.";
			render 'new'
		end
	end

end
