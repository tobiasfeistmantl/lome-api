module RequestHelper
	def json
		@json ||= JSON.parse(response.body)
	end

	def request_with_user_session(method, path, user_session, params={}, headers={})
		params.merge!(sid: user_session.id)
		headers.merge!('Authorization' => "Token token=#{user_session.token}")

		send(method, path, params, headers)
	end
end