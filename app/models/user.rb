class User < ActiveRecord::Base
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

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

	validates :firstname, length: { maximum: 15 }, if: :firstname?
	validates :firstname, presence: {
		message: I18n.t('activerecord.errors.messages.cannot_be_blank_if_attribute_set',attribute: User.human_attribute_name("lastname")) 
	}, if: :lastname?

	validates :lastname, length: { maximum: 25 }, if: :lastname?
	validates :lastname, presence: {
		message: I18n.t('activerecord.errors.messages.cannot_be_blank_if_attribute_set', attribute: User.human_attribute_name("firstname"))
	}, if: :firstname?

	validates :username, presence: true
	validates :password, length: { minimum: 7 }
	validates :email, format: { with: EMAIL_REGEX }, if: :email?

	def name
		[firstname, lastname].join(" ") if firstname.present? && lastname.present?
	end

	def first_or_lastname_present?
		firstname.present? || lastname.present?
	end
end
