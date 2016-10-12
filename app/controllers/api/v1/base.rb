class Api::V1::Base < ApplicationController
	include Api::V1::UsersHelper

	protect_from_forgery with: :null_session

	before_action :authorize!

	rescue_from ActionControl::NotAuthorizedError, with: :user_not_authorized

	private
	
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