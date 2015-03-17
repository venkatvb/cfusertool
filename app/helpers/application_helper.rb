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

	def getFriendList()
		return Friend.where(:account_id => get_account_id ).select( :handle )
	end


	def getFriendsInformation()
		friends = getFriendList()
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
		#     { y: 'KaranAggarwal', label: 100 },
		#     { y: 'roopesh', label: 100 }

		answerString = ""
		details = resultJson["result"]
		details.each_with_index do |detail, index|
			if index == details.size - 1
				answerString = answerString + "{ y: #{detail['rating']}, label: '#{detail['handle']}' }"
				next
			end
			answerString = answerString + "{ y: #{detail['rating']}, label: '#{detail['handle']}' },"
		end
		return answerString
	end

	def getArrayOfFriendsInformation()

	end
end
