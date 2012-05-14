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

		# Build a word frequency array
		#
		def word_freq(options={})
			# Default parameters
			params = {
				tweets: 1000
			}
			params.merge!(options)

			# Fetch Tweets if necessary
			fetch_timeline(params[:tweets]) if @timeline.count < params[:tweets]

			freqDist = {}

			@timeline.each do |tweet|
				tweet.text.split.each do |word|
					if freqDist.has_key? word
						freqDist[word] += 1
					else
						freqDist[word] = 1
					end
				end
			end
			freqDist.sort_by { |k,v| -v }
		end

		# Print word frequency distribution
		#
		def print_word_freq(options={})
			opts = {
				tweets: 1000
			}
			opts.merge!(options)
			dist = word_freq(opts)
			opts[:count] ||= dist.count
			dist[0,opts[:count]].each { |k,v| puts "#{k} (#{v})" }
		end

		# Fetches user timeline and caches it in the @timeline field.
		#
		# @todo Duplicate tweets due to max_id
		#
		# @param [Integer] count the number of Tweets to fetch
		# @return [Boolean] Success or failure (amount already cached)
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