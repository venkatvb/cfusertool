class Submission 
   include ActiveModel::Validations
   include ActiveModel::Conversion
   extend ActiveModel::Naming
   include Comparable
   # :id # => Unique Identifier for every submission
   # :author # => Handle of the author's name
   # :type # => Practice or contest
   # :verdict # => pass or fail
   attr_accessor :id, :author, :type, :verdict

   def initialize(id, author, type, verdict)
   		@id = id
         @author = author
         @type = type
         @verdict = verdict
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

end
