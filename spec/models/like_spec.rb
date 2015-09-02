require 'rails_helper'

RSpec.describe Like, type: :model do
	before(:each) do
		@like = FactoryGirl.build(:like)
	end

	it "should be a valid like" do
		expect(@like.valid?).to be true
	end

	it "should not be a valid like without post" do
		@like.post = nil

		expect(@like.valid?).to be false
		expect(@like.errors.messages[:post]).to include("can't be blank")
	end

	it "should not be a valid like without user" do
		@like.user = nil

		expect(@like.valid?).to be false
		expect(@like.errors.messages[:user]).to include("can't be blank")
	end
end
