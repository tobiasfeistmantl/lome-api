class Api::V1::User::Post::Base < Api::V1::User::Base
	before_action :set_post
	before_action :authorize!

	protected

	def set_post
		if current_user == @user
			@post = Post.unscoped.where(author: @user).includes(:likes).find(params[:post_id] || params[:id])
		else
			@post = @user.posts.find(params[:post_id] || params[:id])
		end
	rescue ActiveRecord::RecordNotFound
		render "api/v1/errors/default",
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