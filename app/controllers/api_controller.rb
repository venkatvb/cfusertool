class ApiController < ApplicationController
	def getTodos
		response = Hash.new
		if signed_in?
			response[:status] = true
			todos = Todo.select('name, url, description, created_at').all
			response[:result] = todos
		else
			response[:status] = false
			response[:error] = "Not signed in. Please sign in at http://cfusertool.herokuapp.com"
		end
		render json: response
	end
	def addTodo
		@todo = Todo.new
		# Todo write this method :P
	end
end
