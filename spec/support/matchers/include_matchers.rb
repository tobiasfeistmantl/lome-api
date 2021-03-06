RSpec::Matchers.define :include_non_private_user_attributes do |expected|
	match do |actual|
		expect(actual).to include("id", "firstname", "lastname", "username", "follower_count", "posting_privilege", 'verified')

		["username", "follower_count"].each do |key|
			expect(actual[key]).to_not be_nil
		end

		expect(actual["profile_image"]).to include("aspect_ratio", "versions")
		expect(actual["profile_image"]["versions"]).to include("original", "thumbnail")
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

RSpec::Matchers.define :include_private_user_attributes do |expected|
	match do |actual|
		expect(actual).to include("email")
	end

	failure_message do |actual|
		"expected to include private user attributes"
	end

	failure_message_when_negated do |actual|
		"expected not to include private user attributes"
	end

	description do
		"include all private user attributes"
	end
end

RSpec::Matchers.define :include_post_attributes do |expected|
	match do |actual|
		expect(actual).to include("id", "message", "latitude", "longitude", "likes_count", "liked", "status", "created_at")
		
		expect(actual["image"]).to include("aspect_ratio", "versions")
		expect(actual["image"]["versions"]).to include("original", "thumbnail")

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