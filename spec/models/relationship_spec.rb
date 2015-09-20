require 'rails_helper'

RSpec.describe Relationship, type: :model do
	subject { build(:relationship) }
	
	it { is_expected.to be_valid }

	it { is_expected.to belong_to :follower }
	it { is_expected.to belong_to :followed }

	it { is_expected.to validate_presence_of :follower }
	it { is_expected.to validate_presence_of :followed }

	describe "same value for follower and followed" do
		let(:user) { create(:user) }
		subject { build(:relationship, follower: user, followed: user) }

		it { is_expected.to_not be_valid }

		it "returns an error" do
			subject.valid?
			expect(subject.errors.messages[:followed]).to include("can't be the same as the follower")
		end

		it "does not save the subject" do
			expect(subject.save).to be_falsey
		end
	end

	context "uniqueness validations" do
		let(:followed_user) { create(:user) }
		let(:another_followed_user) { create(:user) }
		let(:follower) { create(:user) }
		let(:another_follower) { create(:user) }

		before { create(:relationship, followed: followed_user, follower: follower) }

		it "raises an error on duplicated relationships" do
			expect {
				create(:relationship, followed: followed_user, follower: follower)
			}.to raise_error(ActiveRecord::RecordInvalid)
		end

		it "raises no errors if the followed follows the follower" do
			expect {
				create(:relationship, followed: follower, follower: followed_user) 
			}.to_not raise_error
		end

		it "does not validate @followed alone" do
			expect {
				create(:relationship, followed: followed_user, follower: another_follower)
			}.to_not raise_error
		end

		it "does not validate @follower alone" do
			expect {
				create(:relationship, followed: another_followed_user, follower: follower)
			}.to_not raise_error
		end
	end
end
