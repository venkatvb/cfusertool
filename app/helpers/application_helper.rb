module ApplicationHelper
	
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

	def getStatusOfHandle(handle)
		base_url = "http://codeforces.com/api/user.status?handle="
		url_one = base_url + handle
		resultJson = parse(url_one)	
		result = resultJson["status"]
		return result
	end

	def getFriendsInformation()
		friends = Friend.where(:account_id => get_account_id ).select( :handle )
		# We need to have semicolon seperated list of friends
		commaSeperatedFriendList = get_name + ";"
		friends.each do |f|
			commaSeperatedFriendList = commaSeperatedFriendList + f.handle + ";"
		end
		# here the handles is of the form "venkat;darkshadows;karthikkamal"
		# http://codeforces.com/api/user.info?handles=venkatvb;karanaggarwal;darkshadows
		base_url = "http://codeforces.com/api/user.info?handles="
		url = base_url + commaSeperatedFriendList
		resultJson = parse ( url )

		# Returning FAILED if the status of the resultJson is FAILED
		if resultJson["status"] == "FAILED"
			return resultJson["status"]	
		end

		# From this point The resultant JSON is valid -> to be changd to the below format
		# [
		#     { handle: 'KaranAggarwal', rating: 100 },
		#     { handle: 'roopesh', rating: 100 },
		# ]
		answerString = "["
		details = resultJson["result"]
		details.each do |detail|
			answerString = answerString + "{ handle: '#{detail['handle']}', rating: #{detail['rating']} },"
		end
		answerString = answerString + ']'
		return answerString
	end

	def getArrayOfFriendsInformation()

	end
end
