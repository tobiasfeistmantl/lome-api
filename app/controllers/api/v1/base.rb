include Api::V1::UsersHelper

class Api::V1::Base < ApplicationController
	protect_from_forgery with: :null_session

	before_action :authenticate!
	before_action :authorize!

	rescue_from AccessControl::NotAuthenticatedError, with: :user_not_authenticated
	rescue_from AccessControl::NotAuthorizedError, with: :user_not_authorized

	private

	def authenticated?
		return true if current_user.present?
	end

	def user_not_authenticated
		render 'api/v1/errors/default',
		locals: {
			error: {
				type: "UNAUTHENTICATED",
				message: {
					user: "Please sign in to continue"
				}
			}
		}, status: 401
	end

	def user_not_authorized
		render 'api/v1/errors/default',
		locals: {
			error: {
				type: "UNAUTHORIZED",
				message: {
					user: "You aren't authorized to call this action"
				}
			}
		}, status: 403
	end
end