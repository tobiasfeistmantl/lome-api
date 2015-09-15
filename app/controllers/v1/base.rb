include V1::UsersHelper

class V1::Base < ApplicationController
	before_action :authenticate_user!

	def authenticate_user!
		if current_user.nil?
			render 'v1/errors/default',
			locals: {
				error: {
					type: "UNAUTHENTICATED",
					message: {
						user: "Please sign in to continue"
					}
				}
			}, status: 401 and return
		end
	end
end