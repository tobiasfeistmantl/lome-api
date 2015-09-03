require 'rails_helper'

RSpec.describe User, type: :model do
	before :each do
		@user = FactoryGirl.build(:user, firstname: nil, lastname: nil, email: nil)
	end

	describe "create new one" do
		
		context "with valid data" do
			it "with minimum data" do
				expect(@user).to be_valid
			end

			it "with all data" do
				@user = FactoryGirl.build(:user)

				expect(@user).to be_valid
			end
		end

		context "with invalid data" do

			it "without email" do
				@user.username = nil

				expect(@user).to be_invalid
			end

			it "without password" do
				@user.password = nil

				expect(@user).to be_invalid
			end

			it "with a password shorter than 7 characters" do
				@user.password = '123admin'
				expect(@user).to be_valid

				@user.password = '123'
				expect(@user).to be_invalid
				expect(@user.errors.messages[:password]).to include("is too short (minimum is 7 characters)")
			end
		end

	end

	it "is not raising an error on associations" do
		expect { @user.sessions }.not_to raise_error
		expect(@user.sessions.class).to be UserSession::ActiveRecord_Associations_CollectionProxy

		expect { @user.positions }.not_to raise_error
		expect(@user.positions.class).to be UserPosition::ActiveRecord_Associations_CollectionProxy

		expect { @user.follower }.not_to raise_error
		expect { @user.following }.not_to raise_error
	end

	it "returns nil for full name because of missing first and lastname" do
		expect(@user.name).to be_nil
	end

	it "returns the full name as string" do
		@user = FactoryGirl.build(:user)

		expect(@user.name).to eq("#{@user.firstname} #{@user.lastname}")
	end

	

	it "is deleting depending objects if the it will be destroyed"
end






