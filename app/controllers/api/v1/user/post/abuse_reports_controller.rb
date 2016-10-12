class Api::V1::User::Post::AbuseReportsController < Api::V1::User::Post::Base
	def create
		@report = @post.abuse_reports.new
		@report.reporter = current_user

		if @report.save
			head 201
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

	private

	def authorized?
		if create_action?
			return true if user_signed_in?
		end
	end
end
