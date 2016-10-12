class Api::V1::User::Post::PostsController < Api::V1::User::Post::Base
	skip_before_action :set_post, only: [:index, :create]

	def index
		@posts = @user.posts.newest.paginate(page: params[:page])
	end

	def create
		@post = @user.posts.new post_params

		if @post.save
			render "create", status: 201, location: api_v1_user_post_url(@user, @post)
		else
			render "api/v1/errors/default",
			locals: {
				error: {
					type: "UNABLE_TO_SAVE_POST",
					specific: @post.errors.messages,
					message: {
						user: "Unable to save post"
					}
				}
			}, status: 400
		end
	end

	def show
	end

	def update
		if @post.update post_params
			render "update", status: 200
		else
			render "api/v1/errors/default",
			locals: {
				error: {
					type: "UNABLE_TO_UPDATE_POST",
					specific: @post.errors.messages,
					message: {
						user: "Unable to update post"
					}
				}
			}, status: 400
		end
	end

	def destroy
		if @post.destroy
			head 204
		else
			render "api/v1/errors/default",
			locals: {
				error: {
					type: "UNABLE_TO_DELETE_POST",
					specific: "@post.errors.messages",
					messages: {
						user: "Unable to delete post"
					}
				}
			}, status: 400
		end
	end

	protected

	def post_params
		params.require(:post).permit(:message, :image, :latitude, :longitude, :status)
	end

	def authorized?
		if read_action?
			return true if user_signed_in?
		end

		if write_action?
			return true if (current_user == @user && current_user.posting_privilege) || (current_user && current_user.admin?)
		end

		if update_action? || destroy_action?
			return true if current_user && current_user.moderator?
		end
	end
end
