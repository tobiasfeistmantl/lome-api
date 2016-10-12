class Api::V1::User::Session::Base < Api::V1::User::Base
	before_action :set_user_session
	before_action :authorize!

	protected

	def set_user_session
		@user_session = @user.sessions.find(params[:session_id] || params[:id])
	rescue ActiveRecord::RecordNotFound
		render "api/v1/errors/default",
		locals: {
			error: {
				type: "USER_SESSION_NOT_FOUND",
				message: {
					user: "Session was not found"
				}
			}
		}, status: 404
	end
end