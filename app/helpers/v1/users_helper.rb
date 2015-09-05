include ActionController::HttpAuthentication::Token
include ActionController::HttpAuthentication::Token::ControllerMethods
include ActiveSupport::SecurityUtils

module V1::UsersHelper
	def current_user
		unless @current_user
			if session_id = params[:sid]
				if request.authorization && token = token_and_options(request)[0]
					if user_session = UserSession.includes(:user).find_by(id: session_id)
						if secure_compare(user_session.token, token)
							@current_user = user_session.user
						end
					end
				end
			end
		end

		return @current_user
	end

	def user_signed_in?
		current_user.present?
	end
end