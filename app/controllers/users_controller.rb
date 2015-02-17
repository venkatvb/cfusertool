class UsersController < ApplicationController
	
	
	def index
		if !signed_in?
			flash[:danger] = "Oh snap! You should Sign in now! then try again.";
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

	def getUniqueProblems(subms)
		problems = []
		subms.each do |subm|
			temp = getProblem( subm )
			unless problems.any? { |problem| problem.id == temp.id }
				problems << temp
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

	def getNotDone(sub1, sub2)
		problems1 = getUniqueProblems(sub1)
		problems2 = getUniqueProblems(sub2)
		return problems2 - problems1
	end

	def work
		base_url = "http://codeforces.com/api/user.status?handle="
		@one = params[:handle1]
		@two = params[:handle2]
		url_one = base_url + @one;
		url_two = base_url + @two;
		handle1 = parse(url_one)		#uncomment this in production
		handle2 = parse(url_two)		#uncomment this in production
		#handle1 = parse("http://localhost/test/venkatvb.html")		#comment this during production
		#handle2 = parse("http://localhost/test/karthikkamal.html")	#comment this during production
		@bnota = getNotDone(handle1["result"], handle2["result"])
	end
end
