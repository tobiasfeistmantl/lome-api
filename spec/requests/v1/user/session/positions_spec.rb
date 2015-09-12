require 'rails_helper'

RSpec.describe "V1::User::Session::Positions", type: :request do
	describe "POST user/:user_id/session/:session_id/positions" do
		let(:user_session) { create(:user_session) }

		it "creates a new position" do
			request_with_user_session :post, "/v1/users/#{user_session.user.id}/sessions/#{user_session.id}/positions", user_session, position: attributes_for(:user_position)

			expect(response).to have_http_status(204)
		end
	end
end
