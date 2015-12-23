include ActionController::HttpAuthentication::Basic

class Api::V1::User::Session::SessionsController < Api::V1::User::Session::Base
	skip_before_action :set_user, :authenticate!, :authorize!, only: [:create]
	before_action only: [:create] { authenticate!(:authenticated_with_basic?) }
	before_action :set_user_session, only: [:destroy]

	def create
		@user_session = @user.sessions.new

		if @user_session.save
			render 'create', status: 201, location: api_v1_user_session_url(@user, @user_session)
		else
			render "api/v1/errors/default",
			locals: {
				error: {
					type: "UNABLE_TO_CREATE_SESSION",
					message: {
						user: "Unable to log in"
					}
				}
			}, status: 400
		end
	end

	def destroy
		if @user_session.destroy
			render nothing: true, status: 204
		else
			render "api/v1/errors/default",
			locals: {
				error: {
					type: "UNABLE_TO_DESTROY_SESSION",
					message: {
						user: "Unable to log out"
					}
				}
			}, status: 500
		end
	end

	private

	def authenticated_with_basic?
		if request.authorization
			username, password = user_name_and_password(request)
			@user = ::User.find_by(username: username)
			return true if @user && @user.authenticate(password)
		end
	end
end
