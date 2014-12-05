class UsersController < ApplicationController
	
	
	def index
	end

	def parse(url)
		require "net/http"
		require "uri"
		require "json"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Get.new(uri.request_uri)
		response = http.request(request)
		return JSON.parse(response.body)
	end

	def getUniqueProblems(submissions)
		a = []
		submissions.each do |i|
			a << i["problem"]["name"]
		end
		return a.uniq
	end

	def getArrayOfUniqId(submissions)
		a = []
		submissions.each do |i|
			a << (i["problem"]["contestId"].to_s + i["problem"]["index"].to_s)
		end
		return a.uniq
	end

	def hashifyIt(id, index, name, points)
		ret = {}
		ret["contestId"] = id;
		ret["index"] = index
		ret["name"] = name
		ret["points"] = points
		return ret;
	end

	def getArrayOfFullUniqProblems(submissions, uniq)
		a = []
		done = []
		submissions.each do |problem|
			if uniq.include?(problem["problem"]["contestId"].to_s + problem["problem"]["index"].to_s)
				if !(done.include?(problem["problem"]["contestId"].to_s + problem["problem"]["index"].to_s))
					done << (problem["problem"]["contestId"].to_s + problem["problem"]["index"].to_s)
					a << hashifyIt(problem["problem"]["contestId"], problem["problem"]["index"], problem["problem"]["name"], problem["problem"]["points"])
				end
			end
		end
		return a
	end

	def getNotDone(one, two)
		oneUniq = getArrayOfUniqId(one)
		twoUniq = getArrayOfUniqId(two)
		result = twoUniq - oneUniq
		return getArrayOfFullUniqProblems(two, result)
	end

	def work
		base_url = "http://codeforces.com/api/user.status?handle="
		@one = params[:handle1]
		@two = params[:handle2]
		url_one = base_url + @one;
		url_two = base_url + @two;
		#handle1 = parse(url_one)		#uncomment this in production
		#handle2 = parse(url_two)		#uncomment this in production
		handle1 = parse("http://localhost/test/venkatvb.html")		#comment this during production
		handle2 = parse("http://localhost/test/karthikkamal.html")	#comment this during production
		@bnota = getNotDone(handle1["result"], handle2["result"])
	end
end
