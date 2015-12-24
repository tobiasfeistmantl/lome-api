class Admin::DashboardController < Admin::Base
	def show
	end

	private

	def authenticated?
		return true if admin_signed_in?
	end

	def authorized?
		return true if current_admin.moderator? || current_admin.admin?
	end
end
