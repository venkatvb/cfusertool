class SpojController < ApplicationController

	@@userBaseUrl = "http://www.spoj.com/users/"
	@@userListFromInstitutionBaseUrl = "http://www.spoj.com/ranks/users/"
	@@problemInformationBaseUrl = "http://www.spoj.com/problems/"
	@@problemRankingBaseUrl = "http://www.spoj.com/ranks/"
	@@processed = {}
	@@listOfSpojHandles = []

	def find
	end

	def getNokogiriDoc (url)
		begin
			require 'rubygems'
			require 'nokogiri'
			require 'open-uri'
			require 'uri'
			url = URI.encode(url)
			doc = Nokogiri::HTML(open(url))
			return doc
		rescue Exception => e
			return false
		end
	end

	def storeProblem(name)
		informationUrl = @@problemInformationBaseUrl + name.to_s
		cssSelectorForProblemSetter = "#problem-meta tr:nth-child(1) a"
		cssSelectorForConceptualDifficulty = "#rate-problem-box .progress-value"
		cssSelectorForImplementationDifficulty = "#rate-implementation-box .progress-value"
		cssSelectorForUpvotes = ".label-success"
		cssSelectorForDownvotes = ".label-danger"
		cssSelectorForTags = ".problem-tag"
		
		doc = getNokogiriDoc(informationUrl)

		if doc == false
			return false
		end

		results = {}
		setter = doc.at_css(cssSelectorForProblemSetter).to_s
		conceptualDifficulty = doc.at_css(cssSelectorForConceptualDifficulty).to_s
		implementationDifficulty = doc.at_css(cssSelectorForConceptualDifficulty).to_s
		upvote = doc.at_css(cssSelectorForUpvotes).to_s
		downvote = doc.at_css(cssSelectorForDownvotes).to_s
		tags = []

		doc.css(cssSelectorForTags).each do |tag|
			tags << tag.text
		end

	end

	def spoj (userHandle)
		handle = userHandle
		url = @@userBaseUrl + handle
		cssSelectorForSolvedProblems = ".table-condensed a"
		cssSelectorForTodoProblems = ".table:nth-child(4) a"

		solvedProblems = []
		todoProblems = []
		
		doc = getNokogiriDoc(url)

		if doc == false
			return false
		end

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
		stringOfSolvedProblems = solvedProblems.join(" ")
		stringofTodoProblems = todoProblems.join(" ")

		t = {}
		t[:handle] = handle 
		t[:solved] = stringOfSolvedProblems
		t[:todo] = stringofTodoProblems
		@@listOfSpojHandles << t

	end

	def getSpojHandlesOfInstitution (id)

		institutionId = id
		cssSelectorForUsers = ".table-condensed a"

		spojUsers = []

		url = @@userListFromInstitutionBaseUrl + institutionId.to_s 
		doc = getNokogiriDoc(url)
		doc.css(cssSelectorForUsers).each do |user|
			spojUsers << user["href"].to_s.split('/')[2].to_s
		end

		return spojUsers
	end

	def refresh
		require 'open-uri'
		institutionId = params[:institution]
		handles = getSpojHandlesOfInstitution (institutionId)
		
		threads = []
		handles.each do |handle|
			threads << Thread.new { spoj(handle) }
		end

		threads.each do |thr|
			thr.join
		end

		@@listOfSpojHandles.each do |t|
			store = SpojHandle(t)
			store.save
		end

	end

end
