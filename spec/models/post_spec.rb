require 'rails_helper'

RSpec.describe Post, type: :model do
	subject { build(:post) }

	it { is_expected.to be_valid }

	it { is_expected.to belong_to(:author).class_name('User') }
	it { is_expected.to have_many(:likes).dependent(:destroy) }
	it { is_expected.to have_many(:likers).through(:likes).source(:user) }
	it { is_expected.to have_many(:abuse_reports).class_name('PostAbuseReport').dependent(:destroy) }

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

	context "#liked_by?" do
		let(:like) { create(:like) }
		let(:post) { like.post }
		let(:liker) { like.user }
		let(:another_user) { create(:user) }

		it "returns true for the liker" do
			expect(post.liked_by?(liker)).to be true
		end

		it "returns false for other users" do
			expect(post.liked_by?(another_user)).to be false
		end
	end

	context '#reported?' do
		context 'not reported' do
			it 'returns false' do
				expect(subject.reported?).to be false
			end
		end

		context 'reported' do
			before do
				subject.save
				create :post_abuse_report, post: subject
				subject.reload
			end

			it 'returns true' do
				expect(subject.reported?).to be true
			end
		end
	end
end
