require 'rails_helper'

RSpec.describe Post, type: :model do
	subject { build(:post) }

	it { is_expected.to be_valid }

	it { is_expected.to belong_to(:author) }
	it { is_expected.to have_many(:likes).dependent(:destroy) }
	
	context "without message" do
		subject { build(:post, message: nil) }
		it { is_expected.to be_valid }
	end

	context "without image" do
		subject { build(:post, image: nil) }
		it { is_expected.to be_valid }
	end

	context "without message and image" do
		subject { build(:post, message: nil, image: nil) }
		it { is_expected.to be_invalid }
	end
end
