require 'rails_helper'

RSpec.describe "User Resource", type: :request do
	let(:user_session) { create(:user_session) }

	describe "GET /users" do
		it "returns all users without a search condition" do
			create_list(:user, 20)

			request_with_user_session :get, "/v1/users", user_session

			expect(response).to have_http_status(200)
			expect(json[0]).to include_non_private_user_attributes
		end
		
		it "returns all users with a username search condition" do
			users = create_list(:user, 20)
			random_user = users[Random.rand(20)]

			request_with_user_session :get, "/v1/users", user_session, { q: random_user.username }

			expect(response).to have_http_status(200)
			expect(json[0]).to include_non_private_user_attributes
			expect(json[0]["id"]).to eq(random_user.id)
		end
	end

	describe "POST /users" do
		let(:user) { attributes_for(:user) }

		it "creates a valid user" do
			post "/v1/users", { user: user }

			expect(response).to have_http_status(201)
			expect(json).to include_non_private_user_attributes
			expect(json["id"]).to_not be_nil
		end

		context "with minimum data" do
			let(:user) { attributes_for(:user_with_minimum_data) }

			it "create a valid user" do
				post "/v1/users", { user: user }

				expect(response).to have_http_status(201)
				expect(json).to include_non_private_user_attributes
				expect(json["id"]).to_not be_nil
			end
		end
	end

	describe "GET /users/:id" do
		it "returns the sessions user" do
			user = user_session.user

			request_with_user_session :get, "/v1/users/#{user.id}", user_session

			expect(response).to have_http_status(200)
			expect(json).to include_non_private_user_attributes
			expect(json).to_not include("follow")
			expect(json["id"]).to eq(user.id)
		end

		it "returns another user than the sessions user" do
			other_user = create(:user)

			request_with_user_session :get, "/v1/users/#{other_user.id}", user_session

			expect(response).to have_http_status(200)
			expect(json).to include("follow")
			expect(json).to include_non_private_user_attributes
		end
	end

	describe "PATCH /users/:id" do
		it "updates an user" do
			user = user_session.user
			user_attributes = attributes_for(:user)
			user_attributes.delete(:password)

			request_with_user_session :patch, "/v1/users/#{user.id}", user_session, { user: user_attributes }

			expect(response).to have_http_status(200)
			expect(json).to include("id" => user.id, "firstname" => user_attributes[:firstname], username: user.username, "lastname" => user_attributes[:lastname], "email" => user_attributes[:email])
			expect(json).to include_non_private_user_attributes
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
