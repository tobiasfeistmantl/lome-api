require 'rails_helper'

RSpec.describe User, type: :model do
	subject { build(:user) }

	it { is_expected.to be_valid }

	it { is_expected.to have_secure_password }
	it { is_expected.to validate_length_of(:firstname).is_at_most(15) }
	it { is_expected.to validate_length_of(:lastname).is_at_most(25) }
	it { is_expected.to validate_length_of(:username).is_at_most(30) }
	it { is_expected.to validate_length_of(:password).is_at_least(7) }
	it { is_expected.to validate_presence_of :username }
	it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
	it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

	it { is_expected.to have_db_index(:username) }
	it { is_expected.to have_db_index(:email) }

	it { is_expected.to allow_value(FFaker::Internet.email).for(:email) }
	it { is_expected.to_not allow_value('invalid@@email.com').for(:email) }
	it { is_expected.to_not allow_value('invalid@email..com').for(:email) }

	it { is_expected.to allow_value(FFaker::Internet.user_name).for(:username) }
	it { is_expected.to_not allow_value("invalid__username").for(:username) }
	it { is_expected.to_not allow_value("invalid.-username").for(:username) }
	it { is_expected.to_not allow_value("invalid.username.").for(:username) }
	it { is_expected.to_not allow_value("-invalid.username").for(:username) }

	it { is_expected.to have_many(:sessions).dependent(:destroy) }
	it { is_expected.to have_many(:positions).dependent(:destroy) }
	it { is_expected.to have_many(:active_relationships).dependent(:destroy) }
	it { is_expected.to have_many(:follower) }
	it { is_expected.to have_many(:passive_relationships).dependent(:destroy) }
	it { is_expected.to have_many(:following) }
	it { is_expected.to have_many(:posts).dependent(:destroy) }
	it { is_expected.to have_many(:likes).dependent(:destroy) }
	it { is_expected.to have_many(:liked_posts) }

	it { is_expected.to have_many(:post_abuse_reports).with_foreign_key(:reporter_id) }

	it { is_expected.to define_enum_for(:role).with([:user, :moderator, :admin]) }


	describe "validates presence of firstname if lastname is present" do
		before { allow(subject).to receive(:lastname?) { true } }
		it { is_expected.to validate_presence_of(:firstname).with_message("can't be blank if Lastname is set") }
	end

	context "validates presence of lastname if firstname is present" do
		before { allow(subject).to receive(:firstname?) { true } }
		it { is_expected.to validate_presence_of(:lastname).with_message("can't be blank if Firstname is set") }
	end

	context "with minimum data" do
		subject { build(:user_with_minimum_data) }

		it { is_expected.to be_valid }
	end

	context "firstname and lastname with empty string" do
		subject { build(:user, firstname: "", lastname: "") }

		before { subject.valid? }

		it "returns nil for firstname" do
			expect(subject.firstname).to be_nil
		end


		it "returns nil for lastname" do
			expect(subject.firstname).to be_nil
		end
	end

	describe "#name" do
		context "without first and lastname" do
			let(:user) { build(:user, firstname: nil, lastname: nil) }

			it "returns nil" do
				expect(user.name).to be_nil
			end
		end

		context "with first and lastname" do
			let(:user) { build(:user) }

			it "returns the first and lastname" do
				expect(user.name).to eq([user.firstname, user.lastname].join(" "))
			end
		end
	end

	describe "@email" do
		let(:user) { build(:user, email: "#{FFaker::Internet.email.upcase} ") }
		before { user.valid? }

		it "strips the value and converts uppercase characters into lowercase" do
			expect(user.email).to eq(user.email.strip.downcase)
		end
	end

	describe ".search_by_username" do
		let(:users) { create_list(:user, 10) }

		it "returns only the searched users" do
			user = users[Random.rand(10)]

			expect(User.search_by_username(user.username)).to eq([user])
		end
	end
end






