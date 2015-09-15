require 'rails_helper'

RSpec.describe "Posts Nearby Endpoint", type: :request do
	let(:user_position) { create(:user_position) }
	let(:user_session) { user_position.session }
	let(:posts) { create_list(:post, 50) }

	describe "GET /posts/nearby" do
		before { posts }

		it "returns the 15 nearest posts" do
			request_with_user_session :get, "/v1/posts/nearby", user_session

			expect(response).to have_http_status(200)
			expect(json.count).to eq(15)
			expect(json[0]["user"]).to include("id", "firstname", "lastname", "username")
			expect(json[0]["post"]).to include("id", "message", "image", "latitude", "longitude", "status", "created_at")
			expect(json[0]).to include("distance_in_km")
		end
	end
end
