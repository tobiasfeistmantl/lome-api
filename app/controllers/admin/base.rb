class Admin::Base < ApplicationController
	helper_method :admin_signed_in?, :current_admin

	before_action :authorize!

	rescue_from ActionControl::NotAuthorizedError, with: :user_not_authorized

	private

	def admin_signed_in?
		if session[:admin_id].present? && @admin ||= User.find_by(id: session[:admin_id])
			return true
		end

		false
	end

	def current_admin
		if admin_signed_in?
			return @admin
		end
	end

	def user_not_authorized
		flash[:danger] = "You are not authorized!"
		redirect_back
	end
end