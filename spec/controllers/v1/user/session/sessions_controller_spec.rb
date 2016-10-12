require 'rails_helper'

RSpec.describe Api::V1::User::Session::SessionsController, type: :controller do
	it { is_expected.to use_before_action :set_user }
	it { is_expected.to use_before_action :authorize! }

	describe "POST #create" do
	end

	describe "GET #show" do
	end
	
	describe "DELETE #destroy" do
	end
end
