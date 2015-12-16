class Api::V1::User::Post::ImageController < Api::V1::User::Post::Base
	skip_before_action :set_post, only: [:create]

	def create
		@post = @user.posts.new(image: params[:post][:image], status: 1, latitude: 0, longitude: 0)

		if position = @user.positions.last
			@post.latitude = position.latitude
			@post.longitude = position.longitude
		end

		if @post.save
			render "create", status: 201, location: api_v1_user_post_url(@user, @post)
		else
			render "api/v1/errors/default",
			locals: {
				error: {
					type: "UNABLE_TO_SAVE_POST",
					specific: @post.errors.messages,
					message: {
						user: "Unable to create post for image"
					}
				}
			}, status: 400
		end
	end

	def update
		if @post.update image: params[:post][:image]
			render "update", status: 200
		else
			render "api/v1/errors/default",
			locals: {
				error: {
					type: "UNABLE_TO_UPDATE_IMAGE",
					specific: @post.errors.messages,
					message: {
						user: "Unable to update image"
					}
				}
			}, status: 400
		end
	end
end
