class Relationship < ActiveRecord::Base
	belongs_to :follower, class_name: "User", counter_cache: :followed_count
	belongs_to :followed, class_name: "User", counter_cache: :follower_count

	validates_presence_of [:follower, :followed]
end
