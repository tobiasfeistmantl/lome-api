module RequestHelper
	def json(reload: false)
		@json = nil if reload

		@json ||= JSON.parse(response.body)
	end

	def request_with_user_session(method, path, user_session, params={}, headers={})
		id_and_token = [user_session.id, user_session.token].join(":")

		headers.merge!('Authorization' => "Token token=#{id_and_token}")

		send(method, path, { params: params, headers: headers })
	end

	[:get, :post, :patch, :put, :destroy].each do |verb|
		define_method :"#{verb}_with_user_session" do |path, user_session, params={}, headers={}|
			request_with_user_session verb, path, user_session, params, headers
		end
	end
end