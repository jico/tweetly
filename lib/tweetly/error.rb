module Tweetly
  class Error < StandardError

    # Initializes a new Error object
    #
    # @param [String] message the error message
    # @return [Tweetly::Error]
    def initialize(message)
      super(message)
    end
  end

  class Error::Unauthorized < Tweetly::Error
  end
end