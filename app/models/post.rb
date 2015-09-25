class Post < ActiveRecord::Base
	before_save :store_image_dimensions

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

	protected

	def store_image_dimensions
		if image?
			original_dimensions = ::MiniMagick::Image.open(image.file.file)[:dimensions]
			thumb_dimensions = ::MiniMagick::Image.open(image.thumb.file.file)[:dimensions]

			self.image_dimensions = {
				original: {
					width: original_dimensions[0],
					height: original_dimensions[1]
				},

				thumbnail: {
					width: thumb_dimensions[0],
					height: thumb_dimensions[1]
				}
			}
		end
	end
end
