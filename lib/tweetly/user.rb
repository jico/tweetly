module Tweetly
	
	class User
		attr_accessor :name, :screen_name, :protected, :statuses_count, :timeline

		def initialize(name)
			user = Twitter.user(name)
			unless user.protected?
				@name = user.name
				@screen_name = user.screen_name
				@protected = user.protected?
				@statuses_count = user.statuses_count
				@timeline = []
			end
		end

		# Fetches user timeline and caches it in the @timeline field.
		#
		# @param [Integer] count the number of Tweets to fetch
		# @return [Boolean] Success or
		def fetch_timeline(count=1000)
			# Twitter API limits to 3200 tweets
			count = [count, 3200].min

			if @timeline.count < count
				opts = { trim_user: true }

				while @timeline.length < count
					# Fetch only what we don't have
					opts[:max_id] = @timeline.last.id unless @timeline.empty?

					# Max step count is 200 by API
					# We may need less depending on what's already fetched
					opts[:count] = [200, count - @timeline.count].min

					resp = Twitter.user_timeline(@screen_name, opts)
					resp.each { |tweet| @timeline << tweet }
				end

				return true
			else
				# We've pulled this amount or more already
				return false
			end
		end

	end
end