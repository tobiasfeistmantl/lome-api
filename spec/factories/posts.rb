FactoryGirl.define do
	factory :post do
		message { FFaker::Lorem::paragraph }
		latitude { FFaker::Geolocation.lat }
		longitude { FFaker::Geolocation.lng }
		association :author, factory: :user
		image { File.open(Rails.root.join(["spec", "data", "demo_images", "#{Random.rand(15)}.jpg"].join("/"))) }
		status "published"

		factory :drafted_post do
			status "draft"
		end
	end
end
