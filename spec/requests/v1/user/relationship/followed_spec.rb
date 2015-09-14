require 'rails_helper'

RSpec.describe "User Followed Resource", type: :request do
	let(:user_session) { create(:user_session) }
	let(:user) { user_session.user }

	before { create_list(:relationship, 50, follower: user) }

	describe "GET /user/:user_id/followed" do
		it "returns the 30 first followed users" do
			request_with_user_session :get, "/v1/users/#{user.id}/followed", user_session

			expect(response).to have_http_status(200)
			expect(json["count"]).to eq(user.following.count)

			expect(json["followed_users"].count).to eq(30)
		end
	end
end
