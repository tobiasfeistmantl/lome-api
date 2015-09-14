require 'rails_helper'

RSpec.describe Like, type: :model do
	subject { build(:like) }

	it { is_expected.to be_valid }

	it { is_expected.to belong_to :post }
	it { is_expected.to belong_to :user }

	it { is_expected.to validate_presence_of :post }
	it { is_expected.to validate_presence_of :user }


	context "uniqueness validations" do
		let(:post) { create(:post) }
		let(:another_post) { create(:post) }
		let(:user) { create(:user) }
		let(:another_user) { create(:user) }

		before { create(:like, post: post, user: user) }

		it "validates @user scoped to @post" do
			expect {
				create(:like, post: post, user: user)
			}.to raise_error(ActiveRecord::RecordInvalid)
		end

		it "does not validate @user alone" do
			expect {
				create(:like, post: another_post, user: user)
			}.to_not raise_error
		end

		it "does not validate @post alone" do
			expect {
				create(:like, post: post, user: another_user)
			}.to_not raise_error
		end
	end
end
