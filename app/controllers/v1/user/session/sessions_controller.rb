include ActionController::HttpAuthentication::Basic

class V1::User::Session::SessionsController < V1::User::Session::Base
	skip_before_action :set_user, :authenticate_user!, :authorize_user!, only: [:create]
	before_action :authenticate_user_with_basic!, only: [:create]
	before_action :set_user_session, only: [:destroy]

	def create
		@user_session = @user.sessions.new

		if @user_session.save
			render 'create', status: 201, location: v1_user_session_url(@user, @user_session)
		else
			render "v1/errors/default",
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
			render "v1/errors/default",
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

	protected

	def authenticate_user_with_basic!
		if request.authorization
			username = user_name_and_password(request)[0]
			password = user_name_and_password(request)[1]

			@user = ::User.find_by(username: username)

			unless @user && @user.authenticate(password)
				render "v1/errors/default",
				locals: {
					error: {
						type: "INVALID_CREDENTIALS",
						message: {
							user: "Username or password is invalid"
						}
					}
				}, status: 401 and return
			end
		else
			render "v1/errors/default",
			locals: {
				error: {
					type: "MISSING_CREDENTIALS",
					message: {
						user: "Username or password not provided"
					}
				}
			}, status: 401 and return
		end
	end
end
