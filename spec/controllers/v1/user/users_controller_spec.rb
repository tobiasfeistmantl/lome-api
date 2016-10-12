require 'rails_helper'

RSpec.describe Api::V1::User::UsersController, type: :controller do
	it { is_expected.to use_before_action :set_user }
	it { is_expected.to use_before_action :authorize! }

	let(:user) { create(:user) }

	describe "GET #index" do
		context "without user session" do
			before { get :index }
			it "returns a require user session error" do
				expect(response).to require_user_session
			end
		end

		context "with valid user session" do
			before(:all) { create_list(:user, 30) }
			before { allow(controller).to receive(:current_user).and_return(user) }

			context "without search param" do
				before { process :index, method: :get, format: :json }

				it "returns the first 30 users" do
					expect(assigns(:users)).to match_array(User.order(:username).limit(30))
				end
			end

			context "with search param" do
				before { process :index, method: :get, format: :json, params: { q: user.username } }

				it "returns only the searched user" do
					expect(assigns(:users)).to eq([user])
				end
			end
		end
	end

	describe "POST #create" do
		context "with valid attributes" do
			before { process :create, method: :post, format: :json, params: { user: attributes_for(:user) } }

			it "requires no user session" do
				expect(response).to_not require_user_session
			end

			it "assigns @user" do
				expect(assigns(:user)).to_not be_nil
			end
		end

		it "creates a new user in the database" do
			expect {
				process :create, method: :post, format: :json, params: { user: attributes_for(:user) }
			}.to change(User, :count).by(1)
		end
	end

	describe "GET #show" do
		context "without user session" do
			before { process :show, method: :get, format: :json, params: { id: user } }

			it "returns a require user session error" do
				expect(response).to require_user_session
			end
		end

		context "with valid user session" do
			before { allow(controller).to receive(:current_user).and_return(user) }

			context "request non-existent user" do
				before { process :show, method: :get, format: :json, params: { id: "1254123123" } }

				it "returns a not found error" do
					expect(response).to render_default_error_template
				end
			end

			context "request existent user" do
				before { process :show, method: :get, format: :json, params: { id: user } }

				it "assigns the requested user to @user" do
					expect(assigns(:user)).to eq(user)
				end

				it "returns the show template" do
					expect(response).to render_template(:show)
				end
			end
		end
	end

	describe "PATCH #update" do
		context "without user session" do
			before { process :update, method: :patch, format: :json, params: { id: user, user: attributes_for(:user) } }
			
			it "returns a require user session error" do
				expect(response).to require_user_session
			end
		end

		context "with valid user session" do
			before :each do
				allow(controller).to receive(:current_user).and_return(user)
				process :update, method: :patch, format: :json, params: { id: user, user: attributes_for(:user) }
			end

			it "assigns @user" do
				expect(assigns(:user)).to eq(user)
			end

			it "returns the update template" do
				expect(response).to render_template(:update)
			end
		end
	end

	describe "DELETE #destroy" do
		context "without user session" do
			before { process :destroy, method: :delete, format: :json, params: { id: user } }

			it "returns a require user session error" do
				expect(response).to require_user_session
			end
		end

		context "with another user session" do
			let(:another_user) { create(:user) }
			before { allow(controller).to receive(:current_user).and_return(another_user) }

			it "returns a require authorization error" do
				process :destroy, method: :delete, format: :json, params: { id: user }

				expect(response).to require_authorization
			end

			it "does not delete the user from database" do
				expect {
					process :destroy, method: :delete, format: :json, params: { id: :user }
				}.to change(User, :count).by(0)
			end
		end

		context "with own user session" do
			before { allow(controller).to receive(:current_user).and_return(user) }

			it "deletes the user from database" do
				expect {
					process :destroy, method: :delete, format: :json, params: { id: user }
				}.to change(User, :count).by(-1)
			end
		end
	end
end
