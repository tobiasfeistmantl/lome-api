require 'rails_helper'

RSpec.describe "User Relationship Resource", type: :request do
	let(:user_session) { create(:user_position).session }
	let(:user) { user_session.user }
	let(:followed_user) { create(:user) }
	let(:followed_user_session) { create(:user_session, user: followed_user) }

	describe "POST /users/:user_id/relationships" do
		it "creates a new relationship" do
			request_with_user_session :post, "/v1/users/#{user.id}/relationships", user_session, relationship: { followed_id: followed_user.id }

			expect(response).to have_http_status(204)
		end

		it "creates relationships in both directions and it creates no infinite loop" do
			request_with_user_session :post, "/v1/users/#{user.id}/relationships", user_session, relationship: { followed_id: followed_user.id }
			expect(response).to have_http_status(204)
			request_with_user_session :post, "/v1/users/#{followed_user.id}/relationships", followed_user_session, relationship: { followed_id: user.id }
			expect(response).to have_http_status(204)

			request_with_user_session :get, '/v1/posts/nearby', user_session
			expect(response).to have_http_status(200)
		end
	end

	describe "GET /users/:user_id/relationships?partner_id=:partner_id" do
		let(:partner) { create(:user) }
		let(:partner_session) { create(:user_session, user: partner) }

		it "returns the information about the relationship" do
			request_with_user_session :get, "/v1/users/#{user.id}/relationships?partner_id=#{partner.id}", user_session
			expect(response).to have_http_status(200)
			expect(json).to include("active_relationship" => false, "passive_relationship" => false)

			request_with_user_session :post, "/v1/users/#{user.id}/relationships", user_session, relationship: { followed_id: partner.id }
			expect(response).to have_http_status(204)

			request_with_user_session :get, "/v1/users/#{user.id}/relationships?partner_id=#{partner.id}", user_session
			expect(response).to have_http_status(200)
			expect(json(reload: true)).to include("active_relationship" => true, "passive_relationship" => false)

			request_with_user_session :post, "/v1/users/#{partner.id}/relationships", partner_session, relationship: { followed_id: user.id }

			request_with_user_session :get, "/v1/users/#{user.id}/relationships?partner_id=#{partner.id}", user_session
			expect(response).to have_http_status(200)
			expect(json(reload: true)).to include("active_relationship" => true, "passive_relationship" => true)

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
