require 'rails_helper'

RSpec.describe "Post Like Resource", type: :request do
	let(:a_post) { create(:post) }
	let(:user) { a_post.author }
	let(:user_session) { create(:user_session) }
	let(:likes) { create_list(:like, 40, post: a_post) }

	describe "GET /users/:user_id/post/:post_id/likes" do
		before { likes }

		it "returns 30 last likes" do
			request_with_user_session :get, "/v1/users/#{user.id}/posts/#{a_post.id}/likes", user_session

			expect(response).to have_http_status(200)
			expect(json["count"]).to eq(40)
			expect(json["likes"].count).to eq(30)
		end
	end

	describe "POST /users/:user_id/post/:post_id/likes" do
		it "creates a new like" do
			request_with_user_session :post, "/v1/users/#{user.id}/posts/#{a_post.id}/likes", user_session

			expect(response).to have_http_status(204)
		end
	end

	describe "DELETE /users/:user_id/post/:post_id/likes" do
		before { create(:like, post: a_post, user: user_session.user) }

		it "deletes a like" do
			request_with_user_session :delete, "/v1/users/#{user.id}/posts/#{a_post.id}/likes", user_session

			expect(response).to have_http_status(204)
		end
	end
end