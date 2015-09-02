FactoryGirl.define do
  factory :user_session do
    user
	token { generate_token }
  end

end
