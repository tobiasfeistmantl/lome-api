require 'rails_helper'

RSpec.describe "User Post Resource", type: :request do
	let(:user) { create(:user) }
	let(:user_session) { create(:user_session) }

	describe "GET /users/:user_id/posts" do
		let(:posts) { create_list(:post, 50, author: user) }
		let(:drafted_posts) { create_list(:drafted_post, 5, author: user) }

		before do
			posts
			drafted_posts
		end

		it "returns the 30 last published posts" do
			request_with_user_session :get, "/v1/users/#{user.id}/posts", user_session

			expect(response).to have_http_status(200)
			expect(json.count).to eq(30)
			expect(json[0]).to include("message", "image", "latitude", "longitude", "like_count")
		end
	end

	describe "POST /users/:user_id/posts" do
		let(:user) { user_session.user }

		it "creates a new drafted post" do
			request_with_user_session :post, "/v1/users/#{user.id}/posts", user_session, post: attributes_for(:drafted_post)

			expect(response).to have_http_status(201)
			expect(json).to include("id", "message", "image", "latitude", "longitude")
			expect(json["status"]).to eq("draft")
		end

		it "creates a new published post" do
			request_with_user_session :post, "/v1/users/#{user.id}/posts", user_session, post: attributes_for(:post)
			expect(json).to include("id", "message", "image", "latitude", "longitude")
			expect(json["status"]).to eq("published")
		end
	end

	describe "GET /users/:user_id/posts/:id" do
		let(:post) { create(:post, author: user) }

		context "published posts" do
			context "as another user" do
				it "returns the post" do
					request_with_user_session :get, "/v1/users/#{user.id}/posts/#{post.id}", user_session

					expect(response).to have_http_status(200)
					expect(json).to include("id", "message", "image", "latitude", "longitude", "like_count")
					expect(json).not_to include("status")
				end
			end

			context "as owner" do
				let(:user_session) { create(:user_session, user: user) }

				it "returns the post to the owner" do
					request_with_user_session :get, "/v1/users/#{user.id}/posts/#{post.id}", user_session

					expect(response).to have_http_status(200)
					expect(json).to include("id", "message", "image", "latitude", "longitude", "like_count", "status")
				end
			end
		end

		context "drafted posts" do
			let(:post) { create(:drafted_post, author: user) }

			context "as another user" do
				it "returns not found error" do
					request_with_user_session :get, "/v1/users/#{user.id}/posts/#{post.id}", user_session

					expect(response).to have_http_status(404)
				end
			end

			context "as owner" do
				let(:user_session) { create(:user_session, user: user) }

				it "returns the drafted post" do
					request_with_user_session :get, "/v1/users/#{user.id}/posts/#{post.id}", user_session

					expect(response).to have_http_status(200)
					expect(json).to include("id", "message", "image", "latitude", "longitude", "status")
				end
			end
		end
	end

	describe "PATCH /users/:user_id/posts/:id" do
		let(:user_session) { create(:user_session, user: user) }
		let(:updated_post_attributes) { attributes_for(:post) }
		let(:post) { create(:post, author: user) }

		it "updates the post and returns it" do
			request_with_user_session :patch, "/v1/users/#{user.id}/posts/#{post.id}", user_session, post: updated_post_attributes

			expect(response).to have_http_status(200)
			expect(json).to include("id", "image", "status", "like_count")
			expect(json).to include("message" => updated_post_attributes[:message])
		end
	end

	describe "DELETE /users/:user_id/posts/:id" do
		let(:user_session) { create(:user_session, user: user) }
		let(:post) { create(:post, author: user) }

		it "deletes the post" do
			request_with_user_session :delete, "/v1/users/#{user.id}/posts/#{post.id}", user_session

			expect(response).to have_http_status(204)
		end
	end
end











