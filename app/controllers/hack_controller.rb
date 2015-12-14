class HackController < ApplicationController
	def getName
		o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
		string = (0...8).map { o[rand(o.length)] }.join
		return string
	end

	def doit
		@times = 0
		limit = 10
		@error = false
		require 'capybara'
		session = Capybara::Session.new(:selenium)
		session.visit "http://www.ultimatelovecalc.com/love/2580895"

		while @times <= limit
			if session.has_content?("Your Full Name")
			  session.fill_in('fname', :with => getName)
			  session.fill_in('cname1', :with => getName)
			  session.fill_in('cname2', :with => getName)
			  session.fill_in('cname3', :with => getName)
			  session.click_button('Calculate')
			  puts "cracked " + @times.to_s
			  @times += 1
			  session.driver.go_back
			else
			  @error = true
			  puts ":( no tagline fonud, possibly something's broken"
			end
		end
	end
end
