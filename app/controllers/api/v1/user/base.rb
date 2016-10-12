class Api::V1::User::Base < Api::V1::Base
	before_action :set_user
	before_action :authorize!

	private

	def set_user
		@user = ::User.find(params[:user_id] || params[:id])
	rescue ActiveRecord::RecordNotFound
		render 'api/v1/errors/default',
		locals: {
			error: {
				type: "USER_NOT_FOUND",
				message: {
					user: "This user was not found"
				}
			}
		}, status: 404
	end
end