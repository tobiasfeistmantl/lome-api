class V1::User::Post::PostsController < V1::User::Post::Base
	skip_before_action :set_post, only: [:index, :create]
	skip_before_action :authorize_user!, only: [:index, :show]

	def index
		@posts = @user.posts.published.newest.includes(:likes).paginate(page: params[:page])
	end

	def create
		@post = @user.posts.new post_params

		if @post.save
			render "create", status: 201, location: v1_user_post_url(@user, @post)
		else
			render "v1/errors/default",
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
			render "v1/errors/default",
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
			render nothing: true, status: 204
		else
			render "v1/errors/default",
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
end