FactoryGirl.define do
  factory :user_position do
	association :session, factory: :user_session
	latitude { FFaker::Geolocation.lat }
	longitude { FFaker::Geolocation.lng }
  end

end
