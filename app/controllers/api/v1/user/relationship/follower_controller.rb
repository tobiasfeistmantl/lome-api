class Api::V1::User::Relationship::FollowerController < Api::V1::User::Relationship::Base
	def index
		@follower = @user.follower.paginate(page: params[:page])
		@count = @user.follower.count
	end

	private

	def authorized?
		return true if user_signed_in?
	end
end
