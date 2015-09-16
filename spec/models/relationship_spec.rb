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
end
