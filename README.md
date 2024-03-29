# Tweetly

Generate nifty word frequency distributions from your Twitter statuses.

Written and tested in __Ruby 1.9.3__

Gem hosted on [RubyGems](https://rubygems.org/gems/tweetly), where you can find more documentation.

## Installation

Add this line to your application's Gemfile:

    gem 'tweetly'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tweetly

## Usage

First, let's create a new user.

```ruby
require 'tweetly'
user = Tweetly::User.new('jicooo')
```

Now we can print a word frequency distribution list from the last _tweets_ tweets and limit it to _count_ words like so:

```ruby
user.print_word_freq(tweets: 20, count: 5)
```

which prints:

	for (5)
	$10 (3)
	@julioz2 (3)
	my (3)
	post: (2)

By default, Tweetly pulls the last 1000 tweets from the user's timeline and displays the entire list of words.

```ruby
user.print_word_freq
```

which prints:

	the (262)
	to (179)
	a (165)
	@Sualehh (161)
	my (112)
	RT (107)
	I (105)
	of (100)
	# and so on...

Well, that's not a very interesting list. Let's ignore retweets as well as a few common words. Additionally, let's constrain our list to words of at least length 5, only word characters (i.e. letters, digits, underscores), and case insensitive:

```ruby
options = {
	include_rts: false, 
	ignore: ['the', 'to', 'a', 'I'], 
	min_length: 5, 
	words_only: true, 
	case_sensitive: false
}

user.print_word_freq(options)
```

The above prints out:

	sualehh (206)
	foursquare (31)
	julioz2 (30)
	mlacitation (24)
	compywiz (24)
	right (21)
	think (20)
	pretty (20)

Awesome! That's a great looking list.

If you strictly want the words and not the frequency counts printed, you can pass in the option `print_count: false`. For the above, we would just have

	sualehh
	foursquare
	julioz2
	mlacitation
	compywiz
	right
	think
	pretty

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
