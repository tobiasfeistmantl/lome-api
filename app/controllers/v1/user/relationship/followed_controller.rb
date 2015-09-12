class V1::User::Relationship::FollowedController < V1::User::Relationship::Base
	skip_before_action :authorize_user!, only: [:index]

	def index
		@followed_users = @user.following.paginate(page: params[:page])
		@count = @user.following.count
	end
end
