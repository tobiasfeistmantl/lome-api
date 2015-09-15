RSpec::Matchers.define :include_non_private_user_attributes do |expected|
	match do |actual|
		expect(actual).to include("id", "firstname", "lastname", "username", "follower_count")
		expect(actual["profile_image"]).to include("full", "thumb", "profile")
	end

	failure_message do |actual|
		"expected to include all non-private user attributes"
	end

	failure_message_when_negated do |actual|
		"expected not to include all non-private user attributes"
	end

	description do
		"include all non-private user attributes"
	end
end