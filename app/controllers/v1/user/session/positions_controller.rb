class V1::User::Session::PositionsController < V1::User::Session::Base
	def create
		@position = @user_session.positions.new position_params

		if @position.save
			render nothing: true, status: 204
		else
			render "v1/errors/default",
			locals: {
				error: {
					type: "UNABLE_TO_SAVE_USER_POSITION",
					specific: @position.errors.messages,
					message: {
						user: "Unable to save your current position"
					}
				}
			}, status: 400
		end
	end

	protected

	def position_params
		params.require(:position).permit(:latitude, :longitude)
	end
end
