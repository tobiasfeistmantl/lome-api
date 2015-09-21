module RequestHelper
	def json
		@json ||= JSON.parse(response.body)
	end

	def request_with_user_session(method, path, user_session, params={}, headers={})
		id_and_token = [user_session.id, user_session.token].join(":")

		headers.merge!('Authorization' => "Token token=#{id_and_token}")

		send(method, path, params, headers)
	end
end