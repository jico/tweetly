require 'spec_helper'

describe Tweetly::User do
	context "Initializing a new user" do
		before do
			@user = Tweetly::User.new('jicooo')
		end

		it "should be created successfully" do
      @user.should be_an_instance_of Tweetly::User
    end
	end
end