RSpec::Matchers.define :require_authorization do |expected|
	match do |actual|
		expect(actual).to have_http_status 403
		expect(actual).to render_default_error_template
	end

	failure_message do |actual|
		"expected to require a valid user session which is authorized to access the method"
	end

	failure_message_when_negated do |actual|
		"expected not to require a valid user session which is authorized to access the method"
	end

	description do
		"render unauthorized error"
	end
end