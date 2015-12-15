class ApiController < ApplicationController
	
	@@userBaseUrl = "http://www.spoj.com/users/"

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

	def getHashOfSolvedProblems (userHandle)
		handle = userHandle
		url = @@userBaseUrl + handle
		cssSelectorForSolvedProblems = ".table-condensed a"
		cssSelectorForTodoProblems = ".table:nth-child(4) a"
		
		doc = getNokogiriDoc(url)

		if doc == false
			return false
		end

		t = {}

		doc.css(cssSelectorForSolvedProblems).each do |problem|
			if not problem.text.empty?
				t[problem.text] = "solved"
			end
		end
		doc.css(cssSelectorForTodoProblems).each do |problem|
			if not problem.text.empty?
				t[problem.text] = "todo"
			end
		end

		return t
	end

	def spoj
		handle = params[:handle]
		t = getHashOfSolvedProblems(handle)
		if t.to_s == "false"
			errorMessage = "oh! snap, may be the handle '" + handle + "' is invalid. If you are sure the handle is valid, raise an issue here, https://github.com/venkatvb/cfusertool/issues"
			render json: errorMessage
			return
		end
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
			if t[problem].nil? 
				temp[:attempted] = false
				result << temp
			elsif t[problem] == "todo"
				temp[:attempted] = true
				result << temp
			end
		end
		render json: result
	end

	def spojUser
		items = SpojHandle.all
		render json: items
	end

end
