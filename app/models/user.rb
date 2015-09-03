class User < ActiveRecord::Base
	has_secure_password

	has_many :sessions, class_name: "UserSession", dependent: :destroy
	has_many :positions, through: :sessions

	# The relationships where this user is the follower
	has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
	has_many :following, through: :active_relationships, source: :followed
	# The relationships where this user is the followed user
	has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
	has_many :follower, through: :passive_relationships, source: :follower

	has_many :posts, foreign_key: :author_id

	has_many :liked_posts, class_name: "Like"

	validates :username, presence: true
	validates :password, length: { minimum: 7 }

	def name
		[firstname, lastname].join(" ") if firstname.present? && lastname.present?
	end
end
