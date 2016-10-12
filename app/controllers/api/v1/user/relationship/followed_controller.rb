class Api::V1::User::Relationship::FollowedController < Api::V1::User::Relationship::Base
	def index
		@followed_users = @user.following.paginate(page: params[:page])
		@count = @user.following.count
	end

	private

	def authorized?
		if read_action?
			return true if user_signed_in?
		end
	end
end
