require 'rails_helper'

RSpec.describe "Posts Nearby Endpoint", type: :request do
	describe "GET /posts/nearby" do
		let(:user_session) { create(:user_session) }
		let(:posts) { create_list(:post, 50) }

		context "with user position" do
			let(:user_position) { create(:user_position, session: user_session) }
			

			it "returns the 15 nearest posts" do
				posts  # Create posts
				user_position  # create user position

				request_with_user_session :get, "/v1/posts/nearby", user_session

				expect(response).to have_http_status(200)
				expect(json.count).to eq(15)
				expect(json[0]["user"]).to include_non_private_user_attributes
				expect(json[0]["post"]).to include_post_attributes
				expect(json[0]).to include("distance_in_km")
			end
		end

		context "without user position" do
			it "returns an error" do
				request_with_user_session :get, "/v1/posts/nearby", user_session

				expect(response).to have_http_status(400)
				expect(response).to render_default_error_template
			end
		end
	end
end
