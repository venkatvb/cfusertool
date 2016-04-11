class ApplicationController < ActionController::Base
	protect_from_forgery
	after_filter :set_access_control_headers

	def set_access_control_headers
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Request-Method'] = '*'
	end

	include SessionsHelper
	include ApplicationHelper
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

end
