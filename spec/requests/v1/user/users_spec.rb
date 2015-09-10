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

	describe "show user" do
		it "requests the user of the session" do
			user = user_session.user

			get "/v1/users/#{user.id}", { sid: user_session.id }, { "Authorization" => "Token token=#{user_session.token}" }

			expect(response).to have_http_status(200)
			expect(json).to include("id" => user.id, "firstname" => user.firstname, "lastname" => user.lastname, "username" => user.username, "email" => user.email)
		end

		it "requests another user" do
			other_user = create(:user)

			get "/v1/users/#{other_user.id}", { sid: user_session.id }, { "Authorization" => "Token token=#{user_session.token}" }

			expect(response).to have_http_status(200)
			expect(json).to include("id", "firstname", "lastname", "username", "profile_image")
			expect(json).to_not include("email")
		end
	end

end
