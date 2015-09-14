FactoryGirl.define do
	factory :post do
		message { FFaker::Lorem::paragraph }
		latitude 47.358500
		longitude 11.703402
		association :author, factory: :user
		image { File.open(Rails.root.join(["spec", "data", "test-image.jpeg"].join("/"))) }
		status "published"

		factory :drafted_post do
			status "draft"
		end
	end
end
