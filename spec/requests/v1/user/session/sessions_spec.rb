require 'rails_helper'

RSpec.describe "User Session Resource", type: :request do
	let(:user) { create(:user) }
	let(:user_session) { create(:user_session, user: user) }

	describe "POST /users/sessions" do
		it "returns a new session" do
			post "/v1/users/sessions", {}, { "Authorization" => ActionController::HttpAuthentication::Basic.encode_credentials(user.username, user.password) }

			expect(response).to have_http_status(201)
			expect(json).to include("id", "token")
			expect(json["user"]).to include_non_private_user_attributes
		end
	end

	describe "DELETE /users/:user_id/sessions/:id" do
		it "deletes an user session" do
			request_with_user_session :delete, "/v1/users/#{user.id}/sessions/#{user_session.id}", user_session

			expect(response).to have_http_status(204)
		end
	end
end
