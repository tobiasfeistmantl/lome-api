class V1::User::UsersController < V1::User::Base
	skip_before_action :set_user, only: [:index, :create]
	skip_before_action :authenticate_user!, only: [:create]
	skip_before_action :authorize_user!, only: [:index, :show, :create]

	def index
		@users = ::User.search_by_username(params[:q]).paginate(page: params[:page])
	end

	def create
		@user = ::User.new user_create_params

		if @user.save
			render "create", status: 201, location: v1_user_url(@user)
		else
			render "v1/errors/default",
			locals: {
				error: {
					type: "UNABLE_TO_SAVE_USER",
					specific: @user.errors.messages,
					message: {
						user: "Unable to sign up"
					}
				}
			}, status: 400
		end
	end

	def show
	end

	def update
		if @user.update user_update_params
			render 'update', status: 200
		else
			render "v1/errors/default",
			locals: {
				error: {
					type: "UNABLE_TO_UPDATE_USER",
					specific: @user.errors.messages,
					message: {
						user: "Unable to update user"
					}
				}
			}, status: 400
		end
	end

	def destroy
		if @user.destroy
			render nothing: true, status: 204
		else
			render "v1/errors/default",
			locals: {
				error: {
					type: "UNABLE_TO_DESTROY_USER",
					specific: @user.errors.messages,
					message: {
						user: "Unable to delete user"
					}
				}
			}, status: 500
		end
	end

	private

	def user_create_params
		params.require(:user).permit(:firstname, :lastname, :username, :password, :email, :profile_image)
	end

	def user_update_params
		params.require(:user).permit(:firstname, :lastname, :password, :email, :profile_image)
	end
end
