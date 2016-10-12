class Api::V1::User::UsersController < Api::V1::User::Base
	skip_before_action :set_user, only: [:index, :create]

	def index
		@users = ::User.search_by_username(params[:q]).paginate(page: params[:page])
	end

	def create
		@user = ::User.new user_create_params

		if @user.save
			@current_user = @user  # Is used in the current_user method
			render "create", status: 201, location: api_v1_user_url(@user)
		else
			render "api/v1/errors/default",
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
			render "api/v1/errors/default",
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
			head 204
		else
			render "api/v1/errors/default",
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

	def authorized?
		if read_action?
			return true if user_signed_in?
		end

		if create_action?
			return true unless user_signed_in?
		end

		if update_action? || destroy_action?
			return true if @user == current_user || (current_user && current_user.admin?)
		end
	end

	def user_create_params
		params.require(:user).permit(:firstname, :lastname, :username, :password, :email, :profile_image)
	end

	def user_update_params
		params.require(:user).permit(:firstname, :lastname, :password, :email, :profile_image)
	end
end
