class Admin::PostAbuseReportsController < Admin::Base
	before_action :set_post_abuse_report

	def destroy
		if @post_abuse_report.destroy
			flash[:success] = "Post abuse report deleted"
			redirect_back
		else
			flash[:danger] = "Unable to delete post abuse report"
			redirect_back
		end
	end

	private

	def set_post_abuse_report
		@post_abuse_report = PostAbuseReport.find(params[:post_abuse_report_id] || params[:id])
	rescue ActiveRecord::RecordNotFound
		flash[:danger] = "Post Abuse Report not found"
		redirect_back
	end

	def authenticated?
		return true if admin_signed_in?
	end

	def authorized?
		return true if current_admin.moderator? || current_admin.admin?
	end
end
