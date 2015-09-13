FactoryGirl.define do
  factory :user do
    firstname { FFaker::Name::first_name }
	lastname { FFaker::Name::last_name }
	username { [FFaker::Internet::user_name, Random.rand(100)].join("_") }
	password "123admin"
	email { FFaker::Internet::email }
	profile_image { File.open("#{ENV["HOME"]}/Developer/web/test/test-image.jpeg") }
  end

end
