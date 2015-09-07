class V1::User::Base < V1::Base
	before_action :set_user
	before_action :authorize_user!

	protected

	def set_user
		@user = User.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		render 'v1/errors/default',
			locals: {
				error: {
					type: "USER_NOT_FOUND",
					message: {
						user: "This user was not found"
					}
				}
			}, status: 404
	end

	def authorize_user!
		unless @user == current_user
			render 'v1/errors/default',
				locals: {
					error: {
						type: "FORBIDDEN",
						message: {
							user: "You are not allowed to do this action"
						}
					}
				}, status: 403 and return
		end
	end
end