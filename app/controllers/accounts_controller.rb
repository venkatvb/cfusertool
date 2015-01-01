class AccountsController < ApplicationController

  def new
  	@account = Account.new
  end

  def create
  	@account = Account.new(params[:account])
  	if @account.save
  		#saved successful
  	else
  		render 'new'
  	end
  end

  def show
    
  end
end
