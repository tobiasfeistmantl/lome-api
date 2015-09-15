class V1::User::Post::Base < V1::User::Base
	before_action :set_post

	protected

	def set_post
		if current_user == @user
			@post = @user.posts.unscoped.includes(:likes).find(params[:post_id] || params[:id])
		else
			@post = @user.posts.find(params[:post_id] || params[:id])
		end
	rescue ActiveRecord::RecordNotFound
		render "v1/errors/default",
		locals: {
			error: {
				type: "POST_NOT_FOUND",
				message: {
					user: "This post does not exist"
				}
			}
		}, status: 404
	end
end