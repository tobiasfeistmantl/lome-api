require 'rails_helper'

RSpec.describe "User Follower Resource", type: :request do
	let(:user_session) { create(:user_session) }
	let(:user) { user_session.user }

	before { create_list(:relationship, 50, followed: user) }

	describe "GET /user/:user_id/follower" do
		it "returns the 30 first follower" do
			request_with_user_session :get, "/v1/users/#{user.id}/follower", user_session

			expect(response).to have_http_status(200)
			expect(json["count"]).to eq(user.follower.count)
			expect(json["follower"].count).to eq(30)
		end
	end
end
