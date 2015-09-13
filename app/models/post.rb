class Post < ActiveRecord::Base
	belongs_to :author, class_name: "User"

	has_many :likes, dependent: :destroy

	validates_presence_of [:latitude, :longitude]
	validates_presence_of :message, unless: :image?
	validates_presence_of :image, unless: :message?

	enum status: [:published, :draft]

	mount_uploader :image, PostImageUploader
end
