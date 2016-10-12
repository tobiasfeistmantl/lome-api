class Api::V1::User::Post::LikesController < Api::V1::User::Post::Base
	def index
		@likes = @post.likes.includes(:user).paginate(page: params[:page])
		@count = @post.likes.count
	end

	def create
		unless @post.likes.find_by(user: current_user)
			if @like = @post.likes.create(user: current_user)
				render nothing: true, status: 204
			else
				render "api/v1/errors/default",
				locals: {
					error: {
						type: "UNABLE_TO_CREATE_LIKE",
						specific: @like.errors.messages,
						message: {
							user: "Unable to like post"
						}
					}
				}, status: 400
			end
		else
			render "/api/v1/errors/default",
			locals: {
				error: {
					type: "ALREADY_LIKED",
					message: {
						user: "You already like this post"
					}
				}
			}, status: 400
		end
	end

	def destroy
		if @like = @post.likes.find_by(user: current_user)
			if @like.destroy
				render nothing: true, status: 204
			else
				render "api/v1/errors/default",
				locals: {
					error: {
						type: "UNABLE_TO_DELETE_LIKE",
						specific: @like.errors.messages,
						message: {
							user: "Unable to dislike post"
						}
					}
				}
			end
		else
			render "api/v1/errors/default",
			locals: {
				error: {
					type: "LIKE_NOT_FOUND",
					message: {
						user: "You haven't liked this post"
					}
				}
			}, status: 404
		end
	end

	private

	def authorized?
		if read_action? || write_action?
			return true if user_signed_in?
		end
	end
end
