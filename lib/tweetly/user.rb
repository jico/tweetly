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

		# Builds a word frequency array from recent tweets.
		#
		# @param [Hash] options frequency distribution options
		# @option [Integer] :tweets number of tweets to consider (max 3200)
		# @option [Boolean] :words_only consider only word characers 
		# 	i.e. (letters, symbols, underscores)
		# @option [Boolean] :case_sensitive whether to consider word case
		# @option [Boolean] :include_rts whether to consider retweeted statuses
		# @option [Array<String>] :ignore list of words to ignore
		# @return [Array<Array<String, Integer>>] list of word frequencies in descending order
		def word_freq(options={})
			# Default parameters
			params = {
				tweets: 1000,
				words_only: false,
				case_sensitive: true,
				include_rts: true,
				min_length: nil,
				ignore: []
			}
			params.merge!(options)

			# Fetch Tweets if necessary
			fetch_timeline(params[:tweets]) if @timeline.count < params[:tweets]

			freqDist = {}
			@timeline.each_with_index do |tweet, i|
				# :include_rts option
				next if !params[:include_rts] && tweet.retweeted_status

				tweet.text.split.each do |word|
					# Adjust according to options
					next if params[:ignore].include? word
					word.downcase! if !params[:case_sensitive]
					if params[:words_only]
						word = word.match(/\w+/)
						next unless word
						word = word[0]
					end
					next if params[:min_length] && word.length < params[:min_length]

					if freqDist.has_key? word
						freqDist[word] += 1
					else
						freqDist[word] = 1
					end
				end

				break if i == params[:tweets]
			end
			freqDist.sort_by { |k,v| -v }
		end

		# Prints word frequency distribution list.
		#
		# @param [Hash] options printing options
		# @option [Integer] :tweets number of tweets to consider (default: 100, max: 3200)
		# @option [Integer] :count prints top count of frequency distribution list
		# @option [Boolean] :print_count whether to print count next to each word
		def print_word_freq(options={})
			opts = {
				tweets: 1000,
				print_count: true
			}
			opts.merge!(options)
			dist = word_freq(opts)
			opts[:count] ||= dist.count
			dist[0,opts[:count]].each do |k,v| 
				line = "#{k}"
				line += " (#{v})" if opts[:print_count]
				puts line
			end
			return
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
				opts = { 
					trim_user: 1,
					include_rts: 1
				}

				while @timeline.length < count
					# Fetch only what we don't have
					opts[:max_id] = @timeline.last.id unless @timeline.empty?

					# Max step count is 200 by API
					# We may need less depending on what's already fetched
					opts[:count] = [200, count - @timeline.count].min

					# Fetch an extra since max_id is included
					opts[:count] += 1 if opts[:max_id]

					resp = Twitter.user_timeline(@screen_name, opts)

					# Avoid reinserting max_id tweet
					resp.delete_at(0) if opts[:max_id]

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