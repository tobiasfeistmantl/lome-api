RSpec::Matchers.define :render_default_error_template do |expected|
	match do |actual|
		expect(actual).to render_template('v1/errors/default')
	end

	failure_message do |actual|
		"expected to render default error template"
	end

	failure_message_when_negated do |actual|
		"expected not to render default error template"
	end

	description do
		"render default error template"
	end
end