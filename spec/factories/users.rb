FactoryGirl.define do
  factory :user do
    firstname { FFaker::Name::first_name }
	lastname { FFaker::Name::last_name }
	username { [FFaker::Internet::user_name, Random.rand(100)].join("_") }
	password "123admin"
	email { FFaker::Internet::email }
	profile_image { File.open(Rails.root.join(["spec", "data", "test-image.jpeg"].join("/"))) }

	factory :user_with_minimum_data do
		firstname nil
		lastname nil
		email nil
		profile_image nil
	end
  end

end
