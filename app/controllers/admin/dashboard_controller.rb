class Admin::DashboardController < Admin::Base
	def show
		@post_abuse_reports = PostAbuseReport.includes(:reporter, post: [:author]).paginate(page: params[:post_abuse_report_page])
	end

	private

	def authenticated?
		return true if admin_signed_in?
	end

	def authorized?
		return true if current_admin.moderator? || current_admin.admin?
	end
end
