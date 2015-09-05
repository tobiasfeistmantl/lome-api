include V1::UsersHelper

class V1::Base < ApplicationController
	before_action :authenticate_user!

	def authenticate_user!
		if current_user.nil?
			render json: {
				error: {
					type: "UNAUTHENTICATED",
					message: {
						user: "Please sign in to continue"
					}
				}
			}, status: 401
			return
		end
	end
end