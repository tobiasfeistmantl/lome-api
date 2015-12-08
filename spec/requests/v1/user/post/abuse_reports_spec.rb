require 'rails_helper'

RSpec.describe "Post Abuse Report Resource", type: :request do
	let(:a_post) { create(:post) }
	let(:reporter) { create(:user) }
	let(:user_session) { create(:user_session, user: reporter) }

	describe 'POST /v1/users/:user_id/posts/:post_id/abuse_reports' do
		it 'creates a new abuse report' do
			request_with_user_session :post, "/v1/users/#{a_post.author.id}/posts/#{a_post.id}/abuse_report", user_session

			expect(response).to have_http_status(201)
			expect(response.body).to be_blank

			expect(a_post.reload.reported?).to be true
			expect(assigns(:report).reporter).to eq(reporter)
		end
	end
end
