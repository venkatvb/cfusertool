class FriendsController < ApplicationController
	
	def new
		if signed_in?
			@friend = Friend.new
			@myfriend = Friend.all
			@index = 1
		else
			flash.delete(:success)
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
			status = getStatusOfHandle(@friend.handle)
			if status != "OK"
				@myfriend = Friend.all
				flash.delete(:success)
				flash[:danger] = "Uh.! The user with the handle #{@friend.handle} doesn't exist."
				render 'new'
			else
			  	if @friend.save
			  		#saved successful
			  		@myfriend = Friend.all
			  		flash.delete(:danger)
			  		flash[:success] = "yay! #{@friend.handle} is added."
			  		render 'new'
			  	else
			  		flash.delete(:success)
			  		flash[:danger] = "Oh something went wrong! please try again later.";
			  		render 'new'
			  	end
			end
		else
			flash[:danger] = "Oh snap! You should Sign in now! then try again.";
			render 'new'
		end
	end

end
