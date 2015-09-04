FactoryGirl.define do
  factory :user do
    firstname { FFaker::Name::first_name }
	lastname { FFaker::Name::last_name }
	username { FFaker::Internet::user_name }
	password "123admin"
	email { FFaker::Internet::email }
  end

end
