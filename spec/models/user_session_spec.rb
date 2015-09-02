require 'rails_helper'

RSpec.describe UserSession, type: :model do
  before(:each) do
  	@user_session = FactoryGirl.build(:user_session)
  end

  it "should be a valid session" do
  	expect(@user_session.valid?).to be true
  	expect(@user_session.token).to be_truthy
  end

  it "should not be valid without token or user" do
  	@user_session.token = nil
  	@user_session.user = nil

  	expect(@user_session.valid?).to be false
  	expect(@user_session.errors.messages[:token]).to include("can't be blank")
  	expect(@user_session.errors.messages[:user]).to include("can't be blank")
  end
end
