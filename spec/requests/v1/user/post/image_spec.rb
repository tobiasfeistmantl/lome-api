require 'rails_helper'

RSpec.describe "Post Image Resource", type: :request do
	let(:user_session) { create(:user_session) }
	let(:user) { user_session.user }
	let(:test_image) { Rack::Test::UploadedFile.new(Rails.root.join(["spec", "data", "sunrise-test-image.jpg"].join("/")), "text/jpg") }

	describe "POST /users/:user_id/posts/image" do
		it "uploads an image and returns a new drafted post" do
			request_with_user_session :post, "/v1/users/#{user.id}/posts/image", user_session, image_data: test_image

			expect(response).to have_http_status(201)
			expect(json["post"]).to include_post_attributes
			expect(json["post"]["image"]["high_resolution"]).to_not be_nil
		end
	end

	describe "PATCH /users/:user_id/posts/:id/image" do
		let(:post) { create(:post, author: user) }

		it "updates the image of the post" do
			request_with_user_session :patch, "/v1/users/#{user.id}/posts/#{post.id}/image", user_session, image_data: test_image

			expect(response).to have_http_status(200)
			expect(json["post"]).to include_post_attributes
			expect(json["post"]["image"]["high_resolution"]).to_not be_nil
		end
	end
end
