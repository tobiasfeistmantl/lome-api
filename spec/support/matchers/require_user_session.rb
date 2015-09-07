RSpec::Matchers.define :require_user_session do |expected|
	match do |actual|
		expect(actual).to have_http_status 401
		expect(actual).to render_default_error_template
	end

	failure_message do |actual|
		"expected to require a valid user session to access the method"
	end

	failure_message_when_negated do |actual|
		"expected not to require a valid user session to access the method"
	end

	description do
		"render unauthenticated error"
	end
end