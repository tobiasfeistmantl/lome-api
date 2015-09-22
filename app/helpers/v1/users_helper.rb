include ActionController::HttpAuthentication::Token
include ActionController::HttpAuthentication::Token::ControllerMethods
include ActiveSupport::SecurityUtils

module V1::UsersHelper
	def current_user
		@current_user ||= current_user_session.user if current_user_session
	end

	def current_user_session
		unless @current_user_session
			if request.authorization && token_and_options = token_and_options(request)
				id, token = token_and_options[0].split(":")

				if user_session = UserSession.find_by(id: id)
					if secure_compare(user_session.token, token)
						@current_user_session = user_session
					end
				end
			end
		end

		return @current_user_session
	end

	def user_signed_in?
		current_user.present?
	end
end