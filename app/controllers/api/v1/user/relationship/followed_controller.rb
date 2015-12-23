class Api::V1::User::Relationship::FollowedController < Api::V1::User::Relationship::Base
	skip_before_action :authorize!, only: [:index]

	def index
		@followed_users = @user.following.paginate(page: params[:page])
		@count = @user.following.count
	end
end
