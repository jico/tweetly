# -*- encoding: utf-8 -*-
require File.expand_path('../lib/tweetly/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jico Baligod"]
  gem.email         = ["jico@baligod.com"]
  gem.description   = %q{Twitter user timeline stats.}
  gem.summary       = %q{Generate word frequency distributions from your Twitter statuses.}
  gem.homepage      = "https://github.com/jico/tweetly"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "tweetly"
  gem.require_paths = ["lib"]
  gem.version       = Tweetly::VERSION

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~> 2.9.0"

  gem.add_dependency "twitter"
end
