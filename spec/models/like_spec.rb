require 'rails_helper'

RSpec.describe Like, type: :model do
	
	describe "create new one" do
		before :each do
			@like = FactoryGirl.build(:like)
		end

		context "with valid data" do
			it "with all required data" do
				expect(@like).to be_valid
			end
		end

		context "with invalid data" do
			it "without a post" do
				@like.post = nil

				expect(@like).to be_invalid
				expect(@like.errors.messages[:post]).to include("can't be blank")
			end

			it "without a user" do
				@like.user = nil

				expect(@like).to be_invalid
				expect(@like.errors.messages[:user]).to include("can't be blank")
			end
		end
	end

	
end
