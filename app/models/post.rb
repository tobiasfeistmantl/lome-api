class Post < ActiveRecord::Base
	belongs_to :author, class_name: "User"

	has_many :likes, dependent: :destroy
	default_scope { includes(:likes) }
	default_scope { includes(:author) }

	validates_presence_of [:latitude, :longitude]
	validates_presence_of :message, unless: :image?
	validates_presence_of :image, unless: :message?

	enum status: [:published, :draft]
	default_scope { published }

	mount_uploader :image, PostImageUploader

	reverse_geocoded_by :latitude, :longitude

	scope :newest, -> { order(created_at: :desc) }
end
