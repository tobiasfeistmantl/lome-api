class Post < ActiveRecord::Base
	belongs_to :author, class_name: "User"

	validates_presence_of :message, unless: :image?
	validates_presence_of :image, unless: :message?

	mount_uploader :image, PostImageUploader
end
