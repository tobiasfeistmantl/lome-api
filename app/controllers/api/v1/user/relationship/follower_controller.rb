class Api::V1::User::Relationship::FollowerController < Api::V1::User::Relationship::Base
	skip_before_action :authorize_user!, only: [:index]

	def index
		@follower = @user.follower.paginate(page: params[:page])
		@count = @user.follower.count
	end
end
