class Problem 
   include ActiveModel::Validations
   include ActiveModel::Conversion
   extend ActiveModel::Naming
   include Comparable
   # :id # => Unique Identifier for Problem :contestId + :index # => 444A
   # :name # => Name of the problem
   # :contestId # => ContestId of the Problem
   # :index # => Difficlty Index of the problem
   # :point # => Points for the problem
   # :friendsSubmissions # => Array of friends Submission
   # :type # => Contest, Gym
   attr_accessor :id, :name, :contestId, :index, :point, :friendsSubmissions, :type

   def initialize(id)
   		@id = id
   end

   def <=>(anotherProblem)
		if self.id > anotherProblem.id
			-1
		elsif self.id < anotherProblem.id
			1
		else
			0
		end   			
   end

   def ==(anotherProblem)
      self.id==anotherProblem.id
   end

   #This hash is overloaded to perform Array#(-) 
   #subtraction operation in ruby
   #For instance let a, b is of class Array
   #Then a - b is performed as
   #It creates a hash of b's objects
   #The every 'a'.eql? to O(constant) fetch in hash
   def hash
      self.id.hash
   end

   #Helper method to overload array - operator
   def eql?(anotherProblem)
      self.id.hash == anotherProblem.id.hash
   end

   def getUrl
      base_url = "http://codeforces.com/problemset/problem/"
      return base_url.to_s + self.contestId.to_s + "/" + self.index.to_s
   end

   def addSubmission(submission)
      self.friendsSubmissions << submission
   end

   def solved?
      self.friendsSubmissions.any? { |subm| subm.verdict == "OK" }
   end
end
