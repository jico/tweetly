module Tweetly
	
	class User
		attr_accessor :name, :screen_name, :protected, :statuses_count

		def initialize(name)
			user = Twitter.user(name)
			if user.protected?
				return false
			else
				@name = user.name
				@screen_name = user.screen_name
				@protected = user.protected?
				@statuses_count = user.statuses_count
				return true
			end
		end

	end
end