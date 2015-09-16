class Like < ActiveRecord::Base
	belongs_to :post, counter_cache: true
	belongs_to :user

	validates_presence_of [:post, :user]

	validates_uniqueness_of :user, scope: :post_id
end
