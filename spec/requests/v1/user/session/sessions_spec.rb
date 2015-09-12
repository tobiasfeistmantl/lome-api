require 'rails_helper'

RSpec.describe "User Session Resource", type: :request do
	let(:user_session) { create(:user_session) }
	let(:user) { user_session.user }

	describe "POST /users/sessions" do
	end

	describe "GET /users/:user_id/sessions/:id" do
	end

	describe "DELETE /users/:user_id/sessions/:id" do
	end
end
