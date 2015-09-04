require 'rails_helper'

RSpec.describe UserSession, type: :model do

  describe "create new one" do
    before(:each) do
    	@user_session = build(:user_session)
    end

    context "with valid data" do
      it "is a valid session" do
      	expect(@user_session).to be_valid
      	expect(@user_session.token).to_not be_nil
      end
    end

    context "with invalid data" do
      it "without token or user" do
        @user_session.token = nil
        @user_session.user = nil

        expect(@user_session).to be_invalid
        expect(@user_session.errors.messages[:token]).to include("can't be blank")
        expect(@user_session.errors.messages[:user]).to include("can't be blank")
      end
    end

    it "generates a session token" do
      @user_session = build(:user_session, token: nil)

      token = @user_session.generate_token

      expect(token).to_not be_nil
      expect(@user_session.token).to eq(token)
    end
  end
end
