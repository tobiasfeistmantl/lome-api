require 'rails_helper'

RSpec.describe User, type: :model do
	before(:each) do
		@user = FactoryGirl.build(:user, firstname: nil, lastname: nil, email: nil)
	end

	context "create new user" do

		it "should be valid with minimum data" do
			expect(@user.valid?).to be true
		end

		it "should not be valid without email" do
			@user.username = nil

			expect(@user.valid?).to be false
		end

		it "should not be valid without password" do
			@user.password = nil

			expect(@user.valid?).to be false
		end

		it "should not be valid with password shorter than 7 symbols" do
			@user.password = '123admin'
			expect(@user.valid?).to be true

			@user.password = '123'
			expect(@user.valid?).to be false
			expect(@user.errors.messages[:password]).to include("is too short (minimum is 7 characters)")
		end
	end
end
