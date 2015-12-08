class PostAbuseReport < ActiveRecord::Base
	belongs_to :reporter, class_name: 'User'
	belongs_to :post
end
