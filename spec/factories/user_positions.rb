FactoryGirl.define do
  factory :user_position do
	association :session, factory: :user_session
	latitude 47.358506
	longitude 11.703405
  end

end
