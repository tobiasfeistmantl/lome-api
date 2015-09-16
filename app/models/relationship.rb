class Relationship < ActiveRecord::Base
	belongs_to :follower, class_name: "User", counter_cache: :followed_count
	belongs_to :followed, class_name: "User", counter_cache: :follower_count

	validates_presence_of [:follower, :followed]

	validate :follower_and_followed_are_not_the_same

	protected

	def follower_and_followed_are_not_the_same
		errors.add(:followed, "can't be the same as the follower") if followed == follower
	end
end
