class TodosController < ApplicationController
  def new
  	if signed_in?
		@todo = Todo.new
	else
		flash.delete(:success)
		flash[:danger] = "Oh snap! You should Sign in now! then try again.";
		render 'users/index'	
	end
  end

  def create
  	if signed_in?
  		todo = Todo.new(params[:todo])
  		todo.account_id = get_account_id
  		if todo.save
  			# saved successful
  		else
  			raise "Save failed for some reasons. checkout the params"
  			render 'new'
  		end
  	else
  		raise "the user is not signed in but sent a post request"
  		flash[:danger] = "Oh snap! You should Sign in now! then try again.";
		  render 'new'
  	end
  end

  def list
    if !signed_in?
      flash[:danger] = "Oh snap! You should Sign in now! then try again.";
      render 'sessions/new'
    end
  end

end
