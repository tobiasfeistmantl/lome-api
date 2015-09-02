class UserSession < ActiveRecord::Base
	belongs_to :user

	validates :user, presence: true
	validates :token, presence: true

	def generate_token
		self.token = SecureRandom.urlsafe_base64
	end
end
