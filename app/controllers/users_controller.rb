class UsersController < ApplicationController
		
	
	def index
		if !signed_in?
			flash[:danger] = "Oh snap! You should Sign in now! then try again."
		else
			# getFriendsInformation is defined in application_helper.rb
			@usersInfo = getFriendsInformation
			# if @usersInfo if FAILED then some of the handle is invalid else you get the array of user details as string
			# raise @usersInfo.inspect
		end
	end

	def getCurrentSubmission(subm)
		current = Submission.new(subm["id"], subm["author"]["members"], subm["author"]["participantType"], subm["verdict"])
		return current
	end

	def getProblem(subm)
		probid = (subm["problem"]["contestId"].to_s + subm["problem"]["index"].to_s).to_s
		current = Problem.new( probid )
		current.contestId = subm["problem"]["contestId"]
		current.index = subm["problem"]["index"]
		current.name = subm["problem"]["name"]
		current.point = subm["problem"]["points"]
		current.creationTime = subm["creationTimeSeconds"]
		current.friendsSubmissions = []
		current.friendsSubmissions << getCurrentSubmission(subm)
		return current
	end

	# This method gets the unique problems and also sets the total score
	def getUniqueProblems(subms, val)
		problems = []
		subms.each do |subm|
			temp = getProblem( subm )
			unless problems.any? { |problem| problem.id == temp.id }
				problems << temp
				if val == 1
					@totalscoreA += problems[0].point.to_i
				else
					@totalscoreB += problems[0].point.to_i
				end
			else
				problems.each do |shit|
					if shit.id == temp.id 
						shit.friendsSubmissions << temp.friendsSubmissions[0] 
					end
				end
			end
		end
		return problems
	end

	# Takes two unique submissions and a condition for set difference or intersection
	# Mind it should take """"unique submissions """"
	def getNotDone(problems1, problems2, condition)
		if condition == :true
			return problems2 - problems1
		end 
		return problems1 & problems2
	end

	def work
		base_url = "http://codeforces.com/api/user.status?handle="
		@firstUser = params[:handle1]
		@secondUser = params[:handle2]
		@one = params[:handle1]
		@two = params[:handle2]
		
		# attributes made accessible
		@totalscoreA = 0
		@totalscoreB = 0
		@solvedCountA = 0
		@solvedCountB = 0
		@submissionCountA = 0
		@submissionCountB = 0
		@averageA = 0
		@averageB = 0
		@mostA = 0
		@mostB = 0
		# end of attributes made accessible
		
		url_one = base_url + @one;
		url_two = base_url + @two;
		
		# handle1 = parse(url_one)		#uncomment this in production
		# handle2 = parse(url_two)		#uncomment this in production
		handle1 = parse("http://localhost/test/venkatvb.html")		#comment this during production
		handle2 = parse("http://localhost/test/karthikkamal.html")	#comment this during production

		# setting the number of submission
		@submissionCountA = handle1["result"].length.inspect
		@submissionCountB = handle2["result"].length.inspect


		# getting the unique problems
		problems1 = getUniqueProblems(handle1["result"], 1)
		problems2 = getUniqueProblems(handle2["result"], 2)

		# setting the solvedCount
		@solvedCountA = problems1.length.inspect
		@solvedCountB = problems2.length.inspect

		# computing average number of attempts to solve a problem
		@averageA = @submissionCountA.to_f / @solvedCountA.to_f
		@averageB = @submissionCountB.to_f / @solvedCountB.to_f


		# setting submission union and intersection
		@bnota = getNotDone(problems1, problems2, :true)
		@anotb = getNotDone(problems2, problems1, :true)
		@aandb = getNotDone(problems2, problems1, :false)
	end
end
