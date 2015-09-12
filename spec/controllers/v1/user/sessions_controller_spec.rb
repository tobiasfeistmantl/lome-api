require 'rails_helper'

RSpec.describe V1::User::SessionsController, type: :controller do
	it { is_expected.to use_before_action :set_user }
	it { is_expected.to use_before_action :authenticate_user! }
	it { is_expected.to use_before_action :authorize_user! }
	it { is_expected.to use_before_action :authenticate_user_with_basic! }

	describe "POST #create" do
	end

	describe "GET #show" do
	end
	
	describe "DELETE #destroy" do
	end
end
