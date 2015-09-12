require 'rails_helper'

RSpec.describe UserSession, type: :model do
	subject { build(:user_session) }

	it { is_expected.to be_valid }

	it { is_expected.to validate_presence_of :user }

	it { is_expected.to have_many(:positions).dependent(:destroy) }
	it { is_expected.to belong_to :user }

	describe "#generate_token" do
		subject { create(:user_session) }

		it "returns not nil for @token" do
			expect(subject.token).to_not be_nil
		end
	end
end
