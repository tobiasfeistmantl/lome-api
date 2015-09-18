class V1::Post::NearbyController < V1::Post::Base
	def index
		if @position = current_user_session.positions.last
			@posts = ::Post.near(@position.to_coordinates, 1).paginate(page: params[:page], per_page: 15)
		else
			render "v1/errors/default",
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
end
