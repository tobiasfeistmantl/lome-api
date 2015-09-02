require 'rails_helper'

RSpec.describe UserPosition, type: :model do
	before(:each) do
		@user_position = FactoryGirl.build(:user_position)
	end

	it 'should be a valid' do
		expect(@user_position.valid?).to be true
	end

	it 'should not be valid without user session' do
		@user_position.session = nil

		expect(@user_position.valid?).to be false
		expect(@user_position.errors.messages[:session]).to include("can't be blank")
	end

	it 'should not be valid without latitude or longitude' do
		@user_position.latitude = nil
		@user_position.longitude = nil

		expect(@user_position.valid?).to be false
		expect(@user_position.errors.messages[:latitude]).to include("can't be blank")
		expect(@user_position.errors.messages[:longitude]).to include("can't be blank")
	end
end
