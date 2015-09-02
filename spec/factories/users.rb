FactoryGirl.define do
  factory :user do
    firstname "Max"
	lastname "Mustermman"
	sequence(:username) { |n| "maxmustermann#{n}" }
	password "123admin"
	email {"#{username}@example.com"}
  end

end
