class Api::V1::Post::NearbyController < Api::V1::Post::Base
	def index
		if @position = current_user_session.positions.last
			@posts = ::Post.near(@position.to_coordinates, MAX_DISTANCE).paginate(page: params[:page], per_page: 15)
		else
			render "api/v1/errors/default",
			locals: {
				error: {
					type: "USER_NOT_LOCATED",
					message: {
						user: "Unable to show you posts near your position without localization"
					}
				}
			}, status: 400
		end
	end

	private

	def authorized?
		return true if user_signed_in?
	end
end
