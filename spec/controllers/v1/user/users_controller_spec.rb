require 'rails_helper'

RSpec.describe V1::User::UsersController, type: :controller do
	it { is_expected.to use_before_action :set_user }
	it { is_expected.to use_before_action :authenticate_user! }
	it { is_expected.to use_before_action :authorize_user! }

	let(:user) { create(:user) }

	describe "GET #index" do
		context "without user session" do
			before { get :index, format: :json }
			it { expect(response).to require_user_session }
		end

		context "with user session" do
			before { allow(controller).to receive(:current_user).and_return(user) }

			context "without search param" do
				before { get :index, format: :json }
				it { expect(assigns(:users)).to_not be_nil }
			end

			context "with search param" do
				before { get :index, q: user.username, format: :json }

				it "includes user" do
					expect(assigns(:users)).to include(user)
				end
			end
		end
	end

	describe "POST #create" do
		context "with valid attributes" do
			before { post :create, user: attributes_for(:user), format: :json }
			it { expect(response).to_not require_user_session }
		end

		it "creates a new record in database" do
			expect {
				post :create, user: attributes_for(:user), format: :json
			}.to change(User, :count).by(1)
		end
	end

	describe "GET #show" do
		context "without user session" do
			before { get :show, id: user, format: :json }
			it { expect(response).to require_user_session } 
		end

		context "with user session" do
			before { allow(controller).to receive(:current_user).and_return(user) }

			context "with non-existent user" do
				before { get :show, id: "1254123123", format: :json }
				it { expect(response).to render_default_error_template }
			end

			context "with existent user" do
				before { get :show, id: user, format: :json }

				it "assigns the requested user to @user" do
					expect(assigns(:user)).to eq(user)
				end

				it { expect(response).to render_template(:show) }
			end
		end
	end

	describe "PATCH #update" do
		context "without user session" do
			before { patch :update, id: user, user: attributes_for(:user), format: :json }
			it { expect(response).to require_user_session }
		end

		context "with user session" do
			before :each do
				allow(controller).to receive(:current_user).and_return(user)
				patch :update, id: user, user: attributes_for(:user), format: :json
			end

			it { expect(response).to render_template(:update) }
		end
	end

	describe "DELETE #destroy" do
		context "without user session" do
			before { delete :destroy, id: user, format: :json }
			it { expect(response).to require_user_session }
		end

		context "with another user session" do
			before :each do
				another_user = FactoryGirl.create(:user)
				allow(controller).to receive(:current_user).and_return(another_user)
				delete :destroy, id: user, format: :json
			end

			it { expect(response).to require_authorization }
		end

		context "with user session" do
			before :each do
				allow(controller).to receive(:current_user).and_return(user)
			end

			it "deletes the user from database" do
				expect {
					delete :destroy, id: user, format: :json
				}.to change(User, :count).by(-1)
			end
		end
	end
end
