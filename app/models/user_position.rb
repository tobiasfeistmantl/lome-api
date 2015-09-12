class UserPosition < ActiveRecord::Base
	belongs_to :session, class_name: "UserSession", foreign_key: :user_session_id

	validates_presence_of [:session, :latitude, :longitude]

	reverse_geocoded_by :latitude, :longitude
end
