# Tweetly

Generate nifty word frequency distributions from your Twitter statuses.

Written and tested in __Ruby 1.9.3__.

## Installation

Add this line to your application's Gemfile:

    gem 'tweetly'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tweetly

## Usage

First, let's create a new user.

		>> require 'tweetly'
		>> user = Tweetly::User.new('jicooo')

Now we can print a word frequency distribution list from the last _tweets_ tweets and limit it to _count_ words like so:

		>> user.print_word_freq(tweets: 20, count: 5)
		for (5)
		$10 (3)
		@julioz2 (3)
		my (3)
		post: (2)
		=> nil

By default, Tweetly pulls the last 1000 tweets from the user's timeline and displays the entire list of words.

		>> user.print_word_freq
		the (262)
		to (179)
		a (165)
		@Sualehh (161)
		my (112)
		RT (107)
		I (105)
		of (100)
		# and so on...
		=> nil

Well, that's not a very interesting list. Let's ignore retweets as well as a few common words. Additionally, let's constrain our list to words of at least length 5, only word characters (i.e. letters, digits, underscores), and case insensitive:

		>> user.print_word_freq(include_rts: false, ignore: ['the', 'to', 'a', 'I'], min_length: 5, words_only: true, case_sensitive: false)
		sualehh (206)
		foursquare (31)
		julioz2 (30)
		mlacitation (24)
		compywiz (24)
		right (21)
		think (20)
		pretty (20)
		=> nil

Awesome! That's a great looking list.

If you strictly want the words and not the frequency counts printed, you can pass in the option `print_count: false`. For the above, we would just have

		>> user.print_word_freq(include_rts: false, ignore: ['the', 'to', 'a', 'I'], min_length: 5, words_only: true, case_sensitive: false, print_count: false)
		sualehh
		foursquare
		julioz2
		mlacitation
		compywiz
		right
		think
		pretty
		=> nil

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
