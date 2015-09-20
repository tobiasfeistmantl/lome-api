RSpec::Matchers.define :include_non_private_user_attributes do |expected|
	match do |actual|
		expect(actual).to include("id", "firstname", "lastname", "username", "follower_count", "following")
		expect(actual["profile_image"]).to include("standard_resolution", "thumbnail")
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

RSpec::Matchers.define :include_post_attributes do |expected|
	match do |actual|
		expect(actual).to include("id", "message", "latitude", "longitude", "likes_count", "liked", "status", "created_at")
		expect(actual["image"]).to include("low_resolution", "standard_resolution", "high_resolution", "thumbnail")
		expect(actual["author"]).to include_non_private_user_attributes
	end

	failure_message do |actual|
		"expected to include post attributes"
	end

	failure_message_when_negated do |actual|
		"expected not to include post attributes"
	end

	description do
		"include post attributes"
	end
end