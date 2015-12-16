class Api::V1::User::Post::AbuseReportsController < Api::V1::User::Post::Base
	skip_before_action :authorize_user!, only: :create

	# Create
	def create
		@report = @post.abuse_reports.new
		@report.reporter = current_user

		if @report.save
			render nothing: true, status: 201
		else
			render "api/v1/errors/default",
			locals: {
				error: {
					type: "UNABLE_TO_SAVE_ABUSE_REPORT",
					specific: @report.errors.messages,
					message: {
						user: "Unable to report post"
					}
				}
			}, status: 500
		end
	end
end
