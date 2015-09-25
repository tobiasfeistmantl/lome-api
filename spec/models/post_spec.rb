require 'rails_helper'

RSpec.describe Post, type: :model do
	subject { build(:post) }

	it { is_expected.to be_valid }

	it { is_expected.to belong_to(:author) }
	it { is_expected.to have_many(:likes).dependent(:destroy) }

	it { is_expected.to validate_presence_of(:latitude) }
	it { is_expected.to validate_presence_of(:longitude) }

	it { is_expected.to define_enum_for(:status).with([:published, :draft]) }
	
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

	context "message with empty string" do
		subject { build(:post, message: "") }

		before { subject.valid? }

		it "returns nil for message" do
			expect(subject.message).to be_nil
		end
	end

	context ".newest" do
		let(:posts) { create_list(:post, 10) }

		it "returns the posts descendent ordered by created at" do
			expect(Post.newest).to eq(Post.order(created_at: :desc))
		end
	end
end
