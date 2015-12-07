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
		require 'rubygems'
		require 'nokogiri'
		require 'open-uri'
		handle = params["handle"]
		url = "http://www.spoj.com/users/" + handle
		cssSelectorForSolvedProblems = ".table-condensed a"
		cssSelectorForTodoProblems = ".table:nth-child(4) a"

		spojResults = {}
		solvedProblems = []
		todoProblems = []
		
		doc = Nokogiri::HTML(open(url))
		doc.css(cssSelectorForSolvedProblems).each do |problem|
			if not problem.text.empty?
				solvedProblems << problem.text
			end
		end
		doc.css(cssSelectorForTodoProblems).each do |problem|
			if not problem.text.empty?
				todoProblems << problem.text
			end
		end

		spojResults[:handle] = handle
		spojResults[:solved] = solvedProblems
		spojResults[:todo] = todoProblems
		
		render json: spojResults
	end

end
