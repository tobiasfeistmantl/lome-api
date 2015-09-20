require 'rails_helper'

RSpec.describe "User Relationship Resource", type: :request do
	let(:user_session) { create(:user_session) }
	let(:user) { user_session.user }
	let(:followed_user) { create(:user) }

	describe "POST /users/:user_id/relationships" do
		it "creates a new relationship" do
			request_with_user_session :post, "/v1/users/#{user.id}/relationships", user_session, relationship: { followed_id: followed_user.id }

			expect(response).to have_http_status(204)
		end
	end

	describe "DELETE /users/:user_id/relationships?followed_id=:followed_id" do
		before { create(:relationship, follower: user, followed: followed_user) }

		it "deletes a relationship" do
			request_with_user_session :delete, "/v1/users/#{user.id}/relationships", user_session, relationship: { followed_id: followed_user.id }

			expect(response).to have_http_status(204)
		end
	end
end
