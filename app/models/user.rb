class User < ActiveRecord::Base
	USERNAME_REGEX = /\A(?![-_.])(?!.*[-_.]{2})[a-zA-Z0-9._-]+(?<![-_.])\z/
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

	has_secure_password

	mount_uploader :profile_image, UserProfileImageUploader

	before_save { firstname.strip! if firstname? }
	before_save { lastname.strip! if lastname? }
	before_validation { self.email = email.strip.downcase if email? }
	
	before_save { username.strip! }

	has_many :sessions, class_name: "UserSession", dependent: :destroy
	has_many :positions, through: :sessions, dependent: :destroy

	# The relationships where this user is the follower
	has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
	has_many :following, through: :active_relationships, source: :followed
	# The relationships where this user is the followed user
	has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
	has_many :follower, through: :passive_relationships, source: :follower

	has_many :posts, foreign_key: :author_id, dependent: :destroy

	has_many :liked_posts, class_name: "Like"

	validates :firstname, length: { maximum: 15 }
	validates :firstname, presence: {
		message: I18n.t('activerecord.errors.messages.cannot_be_blank_if_attribute_set',attribute: User.human_attribute_name("lastname")) 
	}, if: :lastname?

	validates :lastname, length: { maximum: 25 }
	validates :lastname, presence: {
		message: I18n.t('activerecord.errors.messages.cannot_be_blank_if_attribute_set', attribute: User.human_attribute_name("firstname"))
	}, if: :firstname?

	validates :username, presence: true,
		uniqueness: { case_sensitive: false },
		format: { with: USERNAME_REGEX },
		length: { maximum: 30 }
	validates :password, length: { minimum: 7 }
	validates :email, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	def name
		[firstname, lastname].join(" ") if firstname.present? && lastname.present?
	end

	def first_or_lastname_present?
		firstname.present? || lastname.present?
	end
end