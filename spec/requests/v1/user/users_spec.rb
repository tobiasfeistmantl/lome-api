require 'rails_helper'

RSpec.describe "User Resource", type: :request do
	let(:user_session) { create(:user_session) }

	describe "GET /users" do
		it "returns all users without a search condition" do
			create_list(:user, 20)

			request_with_user_session :get, "/v1/users", user_session

			expect(response).to have_http_status(200)
			expect(json[0]).to include("id", "firstname", "lastname", "username", "profile_image")
		end
		
		it "returns all users with a username search condition" do
			users = create_list(:user, 20)
			random_user = users[Random.rand(20)]

			request_with_user_session :get, "/v1/users", user_session, { q: random_user.username }

			expect(response).to have_http_status(200)
			expect(json[0]).to include("id" => random_user.id, "username" => random_user.username)
			expect(json[0]["profile_image"]).to include("full", "profile", "thumb")
		end
	end

	describe "POST /users" do
		let(:user) { attributes_for(:user) }

		it "creates a valid user" do
			post "/v1/users", { user: user }

			expect(response).to have_http_status(201)
			expect(json).to include("firstname" => user[:firstname], "lastname" => user[:lastname], "username" => user[:username], "email" => user[:email])
			expect(json).to include("id")
		end
	end

	describe "GET /users/:id" do
		it "returns the sessions user" do
			user = user_session.user

			request_with_user_session :get, "/v1/users/#{user.id}", user_session

			expect(response).to have_http_status(200)
			expect(json).to include("id" => user.id, "firstname" => user.firstname, "lastname" => user.lastname, "username" => user.username, "email" => user.email)
			expect(json).to include("profile_image")
		end

		it "returns another user than the sessions user" do
			other_user = create(:user)

			request_with_user_session :get, "/v1/users/#{other_user.id}", user_session

			expect(response).to have_http_status(200)
			expect(json).to include("id", "firstname", "lastname", "username", "profile_image")
			expect(json).to_not include("email")
		end
	end

	describe "PATCH /users/:id" do
		it "updates an user" do
			user = user_session.user
			user_attributes = attributes_for(:user)

			request_with_user_session :patch, "/v1/users/#{user.id}", user_session, { user: user_attributes }

			expect(response).to have_http_status(200)
			expect(json).to include("id" => user.id, "firstname" => user_attributes[:firstname], "lastname" => user_attributes[:lastname], "email" => user_attributes[:email])
			expect(json).to include("profile_image")
		end
	end

	describe "DELETE /users/:id" do
		it "deletes an user" do
			user = user_session.user

			request_with_user_session :delete, "/v1/users/#{user.id}", user_session

			expect(response).to have_http_status(204)
		end
	end

end
