class Post < ActiveRecord::Base
	before_validation :set_message_to_nil_unless_present

	belongs_to :author, class_name: "User"

	has_many :likes, dependent: :destroy
	has_many :likers, through: :likes, source: :user

	default_scope { includes(:likers) }
	default_scope { includes(:author) }

	validates_presence_of [:latitude, :longitude]
	validates_presence_of :message, unless: :image?
	validates_presence_of :image, unless: :message?

	enum status: [:published, :draft]
	default_scope { published }

	mount_uploader :image, PostImageUploader

	reverse_geocoded_by :latitude, :longitude

	scope :newest, -> { order(created_at: :desc) }

	def liked_by?(user)
		likers.include?(user)
	end

	protected

	def set_message_to_nil_unless_present
		unless message.present?
			self.message = nil
		end
	end
end
