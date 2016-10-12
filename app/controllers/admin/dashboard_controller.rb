class Admin::DashboardController < Admin::Base
	def show
		@post_abuse_reports = PostAbuseReport.includes(:reporter, post: [:author]).paginate(page: params[:post_abuse_report_page])
	end

	private

	def authorized?
		if show_action?
			return true if admin_signed_in?
		end
	end
end
