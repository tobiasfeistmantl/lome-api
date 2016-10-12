class Api::V1::User::Session::PositionsController < Api::V1::User::Session::Base
	def create
		@position = @user_session.positions.new position_params

		if @position.save
			head 204
		else
			render "api/v1/errors/default",
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

	def authorized?
		if create_action?
			return true if current_user_session == @user_session
		end
	end

	def position_params
		params.require(:position).permit(:latitude, :longitude)
	end
end
