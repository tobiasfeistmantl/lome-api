require 'rails_helper'

RSpec.describe Relationship, type: :model do
	
	describe "create new one" do
		before :each do
			@relation = build(:relationship)
		end

		context "with valid data" do
			it "is a valid relation" do
				expect(@relation).to be_valid
			end

		end

		context "with invalid data" do
			it "without follower and followed ID" do
				@relation.follower = nil
				@relation.followed = nil

				expect(@relation).to be_invalid
				expect(@relation.errors.messages[:follower]).to include("can't be blank")
				expect(@relation.errors.messages[:followed]).to include("can't be blank")
			end

		end
	end
end
