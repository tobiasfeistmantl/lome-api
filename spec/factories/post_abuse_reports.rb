FactoryGirl.define do
	factory :post_abuse_report do
		association :reporter, factory: :user
		post
	end

end
