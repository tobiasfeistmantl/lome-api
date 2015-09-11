require 'rails_helper'

RSpec.describe "Users Resource", type: :request do
	let(:user_session) { create(:user_session) }

	describe "search for users" do
		it "lists users without a search condition" do
			create_list(:user, 20)

			get "/v1/users", { sid: user_session.id }, { "Authorization" => "Token token=#{user_session.token}" }

			expect(response).to have_http_status(200)
			expect(json[0]).to include("id", "firstname", "lastname", "username", "profile_image")
		end
		
		it "lists users with a username search condition" do
			users = create_list(:user, 20)
			random_user = users[Random.rand(20)]

			get "/v1/users", { sid: user_session.id, q: random_user.username }, { "Authorization" => "Token token=#{user_session.token}" }

			expect(response).to have_http_status(200)
			expect(json[0]).to include("id" => random_user.id, "username" => random_user.username)
			expect(json[0]["profile_image"]).to include("full", "profile", "thumb")
		end
	end

	describe "create new user" do
		let(:user) { attributes_for(:user) }

		it "creates a valid new user" do
			post "/v1/users", { user: user }

			expect(response).to have_http_status(201)
			expect(User.find_by(email: user[:email])).to_not be_nil
		end
	end

	describe "show user" do
		it "requests the user of the session" do
			user = user_session.user

			get "/v1/users/#{user.id}", { sid: user_session.id }, { "Authorization" => "Token token=#{user_session.token}" }

			expect(response).to have_http_status(200)
			expect(json).to include("id" => user.id, "firstname" => user.firstname, "lastname" => user.lastname, "username" => user.username, "email" => user.email)
			expect(json).to include("profile_image")
		end

		it "requests another user" do
			other_user = create(:user)

			get "/v1/users/#{other_user.id}", { sid: user_session.id }, { "Authorization" => "Token token=#{user_session.token}" }

			expect(response).to have_http_status(200)
			expect(json).to include("id", "firstname", "lastname", "username", "profile_image")
			expect(json).to_not include("email")
		end
	end

	describe "update user" do
		it "updates an existent user" do
			user = user_session.user
			user_attributes = attributes_for(:user)

			patch "/v1/users/#{user.id}", { sid: user_session.id, user: user_attributes }, { "Authorization" => "Token token=#{user_session.token}" }

			expect(response).to have_http_status(200)
			expect(json).to include("id" => user.id, "firstname" => user_attributes[:firstname], "lastname" => user_attributes[:lastname], "email" => user_attributes[:email])
		end
	end

	describe "delete user" do
		it "deletes an existent user" do
			user = user_session.user

			delete "/v1/users/#{user.id}", { sid: user_session.id }, { "Authorization" => "Token token=#{user_session.token}" }

			expect(response).to have_http_status(204)
		end
	end

end
