FactoryGirl.define do
  factory :user do
    firstname "Max"
	lastname "Mustermman"
	username "maxmustermann"
	password "123admin"
	email {"#{username}@example.com"}
  end

end
