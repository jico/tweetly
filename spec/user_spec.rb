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

	context "Fetching a user timeline" do
		before do
			@user = Tweetly::User.new('jicooo')
		end

		it "should fetch 1000 tweets by default" do
			@user.fetch_timeline
			@user.timeline.count.should == 1000
		end

		it "should be able to fetch less than 1000" do
			@user.fetch_timeline(10)
			@user.timeline.count.should == 10
		end

		it "should be able to fetch more than 1000" do
			@user.fetch_timeline(1100)
			@user.timeline.count.should == 1100
		end
	end


end