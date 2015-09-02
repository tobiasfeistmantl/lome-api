require 'rails_helper'

RSpec.describe Relationship, type: :model do
	before(:each) do
		@relation = FactoryGirl.build(:relationship)
	end

	it "should be a valid relation" do
		expect(@relation.valid?).to be true
	end

	it "should not be valid without follower or followed" do
		@relation.follower = nil
		@relation.followed = nil

		expect(@relation.valid?).to be false
		expect(@relation.errors.messages[:follower]).to include("can't be blank")
		expect(@relation.errors.messages[:followed]).to include("can't be blank")
	end
end
