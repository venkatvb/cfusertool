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
end
