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

	def spoj
		items = SpojHandle.all
		solvedHash = {}
		todoHash = {}
		problems = []
		result = []
		items.each do |item|
			listOfSolvedProblems = item.solved.to_s.split
			listOfSolvedProblems.each do |problem|
				problems << problem
				if solvedHash[problem].nil?
					solvedHash[problem] = 1 	
				else
					solvedHash[problem] += 1					
				end
			end
			listOfTodoProblems = item.todo.to_s.split
			listOfTodoProblems.each do |problem|
				problems << problem
				if todoHash[problem].nil?
					todoHash[problem] = 1
				else
					todoHash[problem] += 1
				end			
			end
		end
		problems.uniq!
		problems.each do |problem|
			temp = {}
			temp[:problem] = problem
			if solvedHash[problem].nil?
				temp[:solved] = 0
			else
				temp[:solved] = solvedHash[problem]
			end
			if todoHash[problem].nil?
				temp[:todo] = 0
			else
				temp[:todo] = todoHash[problem]
			end
			result << temp
		end
		render json: result
	end

end
