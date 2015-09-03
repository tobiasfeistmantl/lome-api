require 'rails_helper'

RSpec.describe UserPosition, type: :model do
	
	describe "create new one" do
		before :each do
			@user_position = FactoryGirl.build(:user_position)
		end
	
		context "with valid data" do
			it "is a valid user position" do
				expect(@user_position).to be_valid
			end
		end

		context "with invalid data" do
			it "without user session" do
				@user_position.session = nil

				expect(@user_position).to be_invalid
				expect(@user_position.errors.messages[:session]).to include("can't be blank")
			end

			it "without latitude or longitude" do
				@user_position.latitude = nil
				@user_position.longitude = nil

				expect(@user_position).to be_invalid
				expect(@user_position.errors.messages[:latitude]).to include("can't be blank")
				expect(@user_position.errors.messages[:longitude]).to include("can't be blank")
			end
		end
	end
end
